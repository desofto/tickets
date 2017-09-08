import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UserApi } from '../api/index';

// Component used for logout user. Without template with redirection at the end

@Component({
  template: ''
})

export class UserLogout implements OnInit {
  constructor(
    private user_api: UserApi,
    private router: Router
  ) { }

  ngOnInit() {
    // call logout and redirect to root when finished
    this.user_api.logout().then(() => {
      this.router.navigate(['/']);
    });
  }
}
