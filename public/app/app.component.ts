import { Component, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';

import { Subscription } from 'rxjs/Subscription';
import { CurrentUser } from './services/index';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styles: [
    '.wrapper { background-color: #F1EFE2; padding-left: 1rem; padding-right: 1rem; }',
    '.wrapper2 { background-color: white; padding: 1rem; }',
    '.panel { margin-bottom: 0; }',
    '.panel .panel-heading { background-color: #507AAA; color: white; }',
    '.panel a { color: white; }',
  ]
})

export class AppComponent implements OnDestroy {
  currentUser: any; // user that is logged in

  private subscription: Subscription; // we will unsubscribe to prevent memory leaks

  constructor(
    private currentUserService: CurrentUser
  ) {
    // store currentUser if any and subscribe for changes
    this.currentUser = this.currentUserService.active;
    this.subscription = this.currentUserService.onChange((currentUser: any) => {
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
