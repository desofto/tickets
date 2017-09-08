import { Injectable } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { CurrentUser } from '../services/index';

@Injectable()

// Restricts non-authorized user to access some parts of application. Could be hacked, so it is required same check on backend.

export class AuthGuard implements CanActivate {
  constructor(
    private router: Router,
    private currentUser: CurrentUser
  ) { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    // allows access if current user exists
    if(this.currentUser.active) {
      return true;
    }

    // in other case redirects to login form
    this.router.navigate(['/login']);
    return false;
  }
}
