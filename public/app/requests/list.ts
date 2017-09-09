import { Component } from '@angular/core';
import { RequestApi } from '../api/index';

@Component({
  templateUrl: './list.html'
})

export class RequestList {
  constructor(
    private request_api: RequestApi
  ) { }
}
