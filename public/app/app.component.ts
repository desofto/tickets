import { Component, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';

import { Subscription } from 'rxjs/Subscription';
import { CurrentUser } from './services/index';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html'
})

export class AppComponent implements OnDestroy {
  currentUser: any; // user that is logged in

  private subscription: Subscription; // we will unsubscribe to prevent memory leaks

  constructor(
    private currentUserService: CurrentUser
  ) {
    // store currentUser if any and subscribe for changes
    this.currentUser = this.currentUserService.active;
    this.subscription = this.currentUserService.onChange().subscribe(currentUser => {
      // setTimeout fires view updating
      setTimeout(() => this.currentUser = currentUser);
    });
  }

  unblur() {
    // prevent header to be focused
    (document.activeElement as HTMLElement).blur();
  }

  ngOnDestroy() {
    // unsubscribe from currentUser updates
    this.subscription.unsubscribe();
  }
}
