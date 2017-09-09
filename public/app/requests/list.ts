import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs/Subscription';

import { RequestApi } from '../api/index';
import { CurrentUser } from '../services/index';

@Component({
  selector: 'requests-list',
  templateUrl: './list.html',
  styles: [
    'a { cursor: pointer; }',
  ]
})

export class RequestList implements OnInit, OnDestroy {
  private list: Array<any> = [];
  private subscribtion: Subscription;

  constructor(
    private request_api: RequestApi,
    private currentUser: CurrentUser,
  ) { }

  take(request: any) {
    this.request_api.take(request);
  }

  close(request: any) {
    this.request_api.close(request);
  }

  archive(request: any) {
    this.request_api.archive(request);
  }

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
