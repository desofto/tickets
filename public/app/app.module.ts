import { NgModule }         from '@angular/core';
import { Router }           from '@angular/router';
import { BrowserModule }    from '@angular/platform-browser';
import { FormsModule }      from '@angular/forms';

import { ApiModule }        from './api/module';

import { AppRoutingModule } from './app.routing.module';
import { AppComponent }     from './app.component';
import { UserLogin, UserLogout }  from './user/index';

import { RequestsContainer, RequestList, RequestShow, RequestNew } from './requests/index';

import { AuthGuard } from './guards/index';
import { CurrentUser } from './services/index';

import { LazyLoad, PageNotFoundComponent } from './shared/index';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,

    AppRoutingModule,
    ApiModule
  ],
  declarations: [
    AppComponent,
    UserLogin, UserLogout,
    RequestsContainer, RequestList, RequestShow, RequestNew,
    LazyLoad, PageNotFoundComponent
  ],
  providers: [
    AuthGuard,
    CurrentUser
  ],
  bootstrap: [AppComponent]
})

export class AppModule { }
