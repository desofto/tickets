import { Component } from '@angular/core';
import { RequestApi } from '../api/index';

@Component({
  selector: 'request-new',
  templateUrl: './new.html'
})

export class RequestNew {
  constructor(
    private request_api: RequestApi
  ) { }
}
