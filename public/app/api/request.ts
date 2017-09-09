import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

import 'actioncable-js';
declare let ActionCable: any;

import { CurrentUser } from '../services/index';

import { Observable } from 'rxjs/Observable';
import { Subject } from 'rxjs/Subject';
import { Subscription } from 'rxjs/Subscription';

@Injectable()

export class RequestApi {
  private subject = new Subject<any>();
  public list: Array<any> = [];

  constructor (
    private http: Http,
    private currentUserService: CurrentUser,
  ) {
    let cable = ActionCable.createConsumer(`/cable?auth_token=${this.currentUserService.active.auth_token}`);
    let self = this;
    cable.subscriptions.create({ channel: 'RequestsChannel' }, {
      received(data: any) {
        data = JSON.parse(data);
        if(data.is_new) {
          self.list.unshift(data.request);
          self.subject.next();
        } else {
          self.list.forEach((request: any, index: number, arr: Array<any>) => {
            if(request.id == data.request.id) {
              arr[index] = data.request;
              self.subject.next();
            }
          });
        }
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
        .map(res => res.json())
        .subscribe((response: any) => {
          this.list = this.list.concat(response.requests);
          this.subject.next();
          resolve();
        });
    });
  }

  subscribe(param: any): Subscription {
    return this.subject.asObservable().subscribe(param);
  }
}
