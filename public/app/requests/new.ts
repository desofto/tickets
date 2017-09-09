import { Component, OnInit } from '@angular/core';
import { NotificationsService, SimpleNotificationsComponent } from "angular2-notifications"

import { RequestApi } from '../api/index';

import { CurrentUser } from '../services/index';

@Component({
  selector: 'request-new',
  templateUrl: './new.html',
  styles: [
    '.form { width: 100%; padding-left: 1rem; padding-right: 1rem; margin-bottom: 1rem; }',
    '.form input, .form textarea, .form button { width: 100%; margin-top: 1rem; }',
    '.form textarea { height: 5rem; }',
  ]
})

export class RequestNew implements OnInit {
  private email: string = '';
  private password: string = '';
  private subject: string = '';
  private body: string = '';

  constructor(
    private request_api: RequestApi,
    private currentUser: CurrentUser,
    private notificationsService: NotificationsService,
  ) { }

  create() {
    let draft = {
      email: this.email,
      subject: this.subject,
      body: this.body
    }

    if(this.currentUser.active && this.currentUser.active.auth_token) {
      this.request_api.create(this.subject, this.body).then(() => {
        localStorage.removeItem('draft');
        this.ngOnInit();
      });
    } else {
      localStorage.setItem('draft', JSON.stringify(draft));
      this.request_api.create_unauthenticated(this.subject, this.body, this.email, this.password).then((answer: any) => {
        this.notificationsService.success('Info', answer, {
          timeOut: 30000,
          showProgressBar: true,
          pauseOnHover: true,
          clickToClose: true
        });
        localStorage.removeItem('draft');
        this.ngOnInit();
      }).catch(err => {
        this.notificationsService.error('Ouch!', err, {
          timeOut: 3000,
          showProgressBar: true,
          pauseOnHover: true,
          clickToClose: true
        });
      });
    }
  }

  ngOnInit() {
    let draft = JSON.parse(localStorage.getItem('draft'));

    this.email = draft && draft.email || '';
    this.password = '';
    this.subject = draft && draft.subject || '';
    this.body = draft && draft.body || '';
  }
}
