import { Component, OnInit } from '@angular/core';
import { RequestApi } from '../api/index';
import { CurrentUser } from '../services/index';

@Component({
  templateUrl: './list.html'
})

export class RequestList implements OnInit {
  private list: Array<any> = [];

  constructor(
    private request_api: RequestApi,
    private currentUser: CurrentUser,
  ) { }

  ngOnInit() {
    this.request_api.init().then(() => this.list = this.request_api.list);
    this.request_api.subscribe(() => this.list = this.request_api.list);
  }
}
