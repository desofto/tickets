import { Component, OnInit } from '@angular/core';
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
  private subject: string = '';
  private body: string = '';

  constructor(
    private request_api: RequestApi,
    private currentUser: CurrentUser,
  ) { }

  create() {
    this.request_api.create(this.subject, this.body, this.email).then(() => this.ngOnInit());
  }

  ngOnInit() {
    this.email = '';
    this.subject = '';
    this.body = '';
  }
}
