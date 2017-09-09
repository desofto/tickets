import { Component, OnInit } from '@angular/core';
import { RequestApi } from '../api/index';

@Component({
  templateUrl: './list.html'
})

export class RequestList implements OnInit {
  private list: Array<any> = [];

  constructor(
    private request_api: RequestApi
  ) { }

  ngOnInit() {
    this.request_api.init().then(() => this.list = this.request_api.list);
    this.request_api.subscribe(() => this.list = this.request_api.list);
  }
}
