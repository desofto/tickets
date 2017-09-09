import { Component } from '@angular/core';
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

export class RequestNew {
  constructor(
    private request_api: RequestApi,
    private currentUser: CurrentUser,
  ) { }
}
