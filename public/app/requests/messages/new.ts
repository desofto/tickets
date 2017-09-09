import { Component, Input, OnInit } from '@angular/core';
import { RequestApi } from '../../api/index';

@Component({
  selector: 'request-new-message',
  templateUrl: './new.html',
  styles: [
    '.form { width: 100%; }',
    'textarea, button { width: 100%; }',
    'textarea { min-height: 10rem; }',
  ]
})

export class MessageNew implements OnInit {
  @Input('request') request: any;

  private message: string = '';

  constructor(
    private request_api: RequestApi
  ) { }

  post() {
    this.request_api.post_message(this.request.id, this.message).then(() => this.ngOnInit());
  }

  ngOnInit() {
    this.message = '';
  }
}
