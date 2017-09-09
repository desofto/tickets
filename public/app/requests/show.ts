import { Component } from '@angular/core';
import { RequestApi } from '../api/index';

@Component({
  templateUrl: './show.html'
})

export class RequestShow {
  constructor(
    private request_api: RequestApi
  ) { }
}
