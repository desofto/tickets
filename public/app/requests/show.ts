import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { RequestApi } from '../api/index';

import { Subscription } from 'rxjs/Subscription';

@Component({
  templateUrl: './show.html'
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
