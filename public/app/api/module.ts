import { NgModule }     from '@angular/core';
import { HttpModule }   from '@angular/http';

import { UserApi, RequestApi }   from './index';

@NgModule({
  imports: [
    HttpModule
  ],
  declarations: [
  ],
  exports: [
  ],
  providers: [
    UserApi,
    RequestApi
  ]
})

export class ApiModule {}
