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

  private sort_and_store_list(list: Array<any>) {
    this.list = list.sort((r1, r2) => {
      let p1 = this.status_to_int(r1.status);
      let p2 = this.status_to_int(r2.status);
      if(p1 > p2) {
        return 1;
      }
      if(p1 < p2) {
        return -1;
      }
      if(r1.updated_at > r2.updated_at) {
        return 1;
      }
      if(r1.updated_at < r2.updated_at) {
        return 1;
      }
      return 0;
    });
  }

  private status_to_int(status: string): number {
    return ['open', 'answered', 'closed', 'archived'].indexOf(status);
  }

  ngOnInit() {
    this.request_api.init().then(() => this.sort_and_store_list(this.request_api.list));
    this.subscribtion = this.request_api.subscribe(() => this.sort_and_store_list(this.request_api.list));
  }

  ngOnDestroy() {
    this.subscribtion.unsubscribe();
  }
}
