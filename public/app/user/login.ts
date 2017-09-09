import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NotificationsService, SimpleNotificationsComponent } from "angular2-notifications"

import { UserApi } from '../api/index';

// Login form

@Component({
  templateUrl: './login.html',
  styles: [`
    .form {
      margin: auto;
      width: 20em;
    }
  `]
})

export class UserLogin implements OnInit {
  username: string;
  password: string;

  constructor(
    private user_api: UserApi,
    private router: Router,
    private notificationsService: NotificationsService,
  ) { }

  ngOnInit() {
    this.username = '';
    this.password = '';
  }

  login() {
    // Login user, store user data and redirect to root at end
    this.user_api.login(this.username, this.password)
      .then(() => this.router.navigate(['/']))
      .catch((err) => {
        this.notificationsService.error('Ouch!', err, {
          timeOut: 3000,
          showProgressBar: true,
          pauseOnHover: true,
          clickToClose: true
        });
      });
  }
}
