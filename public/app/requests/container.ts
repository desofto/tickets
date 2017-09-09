import { Component } from '@angular/core';
import { CurrentUser } from '../services/index';

@Component({
  templateUrl: './container.html'
})

export class RequestsContainer {
  constructor(
    private currentUser: CurrentUser
  ) { }
}
