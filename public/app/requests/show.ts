import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { RequestApi } from '../api/index';

import { Subscription } from 'rxjs/Subscription';

@Component({
  templateUrl: './show.html',
  styles: [
    '.request-header { background-color: #ffffdd; border: 1px solid #d7d7d7; padding: 1rem; }',
    '.request-title { font-weight: bolder; height: 3rem; }',
    '.request-label, .request-data { float: left; height: 3rem; }',
    '.request-label { width: 10rem; }',
    '.request-message-header { border-bottom: 1px solid #d7d7d7; }',
    '.request-messages { margin-top: 2rem; }',
  ]
})

export class RequestShow implements OnInit, OnDestroy {
  private request: any;
  private subscription: Subscription;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private request_api: RequestApi
  ) { }

  ngOnInit() {
    this.route.params.subscribe((p: any) => {
      this.request_api.one(p.id).then(request => {
        this.request = request;
        this.subscription = this.request_api.subscribe((request: any) => {
          if(request && this.request.id == request.id) {
            this.request = request;
          }
        });
      }, () => {
        this.router.navigate(['/']);
      });
    });
  }

  ngOnDestroy() {
    if(this.subscription) {
      this.subscription.unsubscribe();
    }
  }
}
