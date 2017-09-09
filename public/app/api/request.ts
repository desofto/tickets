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
  private loading: boolean = false;

  constructor (
    private http: Http,
    private currentUserService: CurrentUser,
  ) {
    this.setupActionCable();
    this.currentUserService.onChange(() => {
      this.setupActionCable();
    });
  }

  private update_request(req: any) {
    this.list.forEach((request: any, index: number, arr: Array<any>) => {
      if(request.id == req.id) {
        this.list[index] = req;
      }
    });
  }

  setupActionCable() {
    if(this.currentUserService.active && this.currentUserService.active.auth_token) {
      let cable = ActionCable.createConsumer(`/cable?auth_token=${this.currentUserService.active.auth_token}`);
      let self = this;
      cable.subscriptions.create({ channel: 'RequestsChannel' }, {
        received(data: any) {
          if(data.is_new) {
            self.list.unshift(data.request);
          } else {
            self.update_request(data.request);
          }
          self.subject.next(data.request);
        }
      });
    }
  }

  init() {
    this.list = [];
    return this.next();
  }

  next() {
    return new Promise((resolve, reject) => {
      if(!this.loading && this.currentUserService.active && this.currentUserService.active.auth_token) {
        this.loading = true;
        this.http.get(`/api/v1/requests?auth_token=${this.currentUserService.active.auth_token}&skip=${this.list.length}`)
          .map(res => res.json())
          .subscribe((response: any) => {
            this.loading = false;
            if(response.requests) {
              this.list = this.list.concat(response.requests);
              this.subject.next();
              resolve();
            }
          });
      }
    });
  }

  subscribe(param: any): Subscription {
    return this.subject.asObservable().subscribe(param);
  }

  one(id: number) {
    return new Promise((resolve, reject) => {
      if(this.currentUserService.active && this.currentUserService.active.auth_token) {
        this.http.get(`/api/v1/requests/${id}?auth_token=${this.currentUserService.active.auth_token}`)
          .map((res: any) => res.json())
          .subscribe((response: any) => {
            resolve(response);
          });
      }
    });
  }

  post_message(request_id: number, message: string) {
    return new Promise((resolve, reject) => {
      if(this.currentUserService.active && this.currentUserService.active.auth_token) {
        this.http.post(`/api/v1/requests/${request_id}/messages?auth_token=${this.currentUserService.active.auth_token}`, { message: { body: message } })
          .map((res: any) => res.json())
          .subscribe((response: any) => {
            resolve();
          });
      }
    });
  }

  take(request: any) {
    return new Promise((resolve, reject) => {
      if(this.currentUserService.active && this.currentUserService.active.auth_token) {
        this.http.put(`/api/v1/requests/${request.id}/take?auth_token=${this.currentUserService.active.auth_token}`, {})
          .map((res: any) => res.json())
          .subscribe((response: any) => {
            this.update_request(response);
            resolve();
          });
      }
    });
  }

  close(request: any) {
    return new Promise((resolve, reject) => {
      if(this.currentUserService.active && this.currentUserService.active.auth_token) {
        this.http.put(`/api/v1/requests/${request.id}/close?auth_token=${this.currentUserService.active.auth_token}`, {})
          .map((res: any) => res.json())
          .subscribe((response: any) => {
            this.update_request(response);
            resolve();
          });
      }
    });
  }

  archive(request: any) {
    return new Promise((resolve, reject) => {
      if(this.currentUserService.active && this.currentUserService.active.auth_token) {
        this.http.put(`/api/v1/requests/${request.id}/archive?auth_token=${this.currentUserService.active.auth_token}`, {})
          .map((res: any) => res.json())
          .subscribe((response: any) => {
            this.update_request(response);
            resolve();
          });
      }
    });
  }
}
