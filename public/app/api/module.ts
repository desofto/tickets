import { NgModule }     from '@angular/core';
import { HttpModule }   from '@angular/http';

import { UserApi }   from './index';

@NgModule({
  imports: [
    HttpModule
  ],
  declarations: [
  ],
  exports: [
  ],
  providers: [
    UserApi
  ]
})

export class ApiModule {}
