import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs/Subscription';

import { RequestApi } from '../api/index';
import { CurrentUser } from '../services/index';


@Component({
  templateUrl: './list.html'
})

export class RequestList implements OnInit, OnDestroy {
  private list: Array<any> = [];
  private subscribtion: Subscription;

  constructor(
    private request_api: RequestApi,
    private currentUser: CurrentUser,
  ) { }

  loadNext() {
    this.request_api.next();
  }

  ngOnInit() {
    this.request_api.init().then(() => this.list = this.request_api.list);
    this.subscribtion = this.request_api.subscribe(() => this.list = this.request_api.list);
  }

  ngOnDestroy() {
    this.subscribtion.unsubscribe();
  }
}
