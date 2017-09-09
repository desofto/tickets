import { Component, Input, OnInit } from '@angular/core';
import { UserApi } from '../api/index';

@Component({
  selector: 'agents-list',
  templateUrl: './list.html',
  styles: [
    '.agents-list { border: 1px solid #d7d7d7; padding: 1rem; margin-bottom: 1rem; }',
    'button.report { width: 100%; margin-bottom: 1rem; }',
  ]
})

export class AgentsList implements OnInit {
  private list: Array<any> = [];
  private loading: boolean = false;

  constructor(
    private user_api: UserApi
  ) { }

  private loadNext() {
    if(!this.loading) {
      this.loading = true;
      this.user_api.agents(this.list.length)
        .then(agents => {
          this.list = this.list.concat(agents);
          this.loading = false;
        })
        .catch(() => this.loading = false);
    }
  }

  ngOnInit() {
    this.list = [];
    this.loadNext();
  }
}
