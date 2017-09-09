import { Component, Input, OnInit } from '@angular/core';
import { UserApi } from '../api/index';

@Component({
  selector: 'agents-new',
  templateUrl: './new.html',
  styles: [
    '.form { width: 100%; }',
    'input { width: 49%; }',
    'input[name=email] { float: left; }',
    'input[name=password] { float: right; }',
    'button { width: 100%; }',
    'input, button { margin-bottom: 1rem; }',
  ]
})

export class AgentNew implements OnInit {
  private email: string = '';
  private password: string = '';

  constructor(
    private user_api: UserApi
  ) { }

  post() {
    this.user_api.create_agent(this.email, this.password).then(() => this.ngOnInit());
  }

  ngOnInit() {
    this.email = '';
    this.password = '';
  }
}
