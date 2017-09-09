import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

import 'actioncable-js';
declare let ActionCable: any;

import { CurrentUser } from '../services/index';

import { Observable } from 'rxjs/Observable';
import { Subject } from 'rxjs/Subject';

@Injectable()

export class RequestApi {
  private subject = new Subject<any>();
  public list: Array<any> = [];

  constructor (
    private http: Http,
    private currentUserService: CurrentUser,
  ) {
    let cable = ActionCable.createConsumer(`/cable?auth_token=${this.currentUserService.active.auth_token}`);
    cable.subscriptions.create({ channel: 'RequestsChannel' }, {
      received(data: any) {
        console.log(data);
      }
    });
  }

  init() {
    this.list = [];
    return this.next();
  }

  next() {
    return new Promise((resolve, reject) => {
      this.http.get(`/api/v1/requests?auth_token=${this.currentUserService.active.auth_token}&skip=${this.list.length}`)
        .subscribe((response: any) => {
          this.list = this.list.concat(response.requests);
          resolve();
        });
    });
  }

  subscribe(param: any) {
    this.subject.asObservable().subscribe(param);
  }
}
