import { NgModule }         from '@angular/core';
import { Router }           from '@angular/router';
import { BrowserModule }    from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FormsModule }      from '@angular/forms';
import { SimpleNotificationsModule } from 'angular2-notifications';

import { ApiModule }        from './api/module';

import { AppRoutingModule } from './app.routing.module';
import { AppComponent }     from './app.component';
import { UserLogin, UserLogout }  from './user/index';

import { RequestsContainer, RequestList, RequestShow, RequestNew } from './requests/index';
import { MessageNew } from './requests/messages/index';

import { AuthGuard } from './guards/index';
import { CurrentUser } from './services/index';

import { LazyLoad, PageNotFoundComponent } from './shared/index';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,

    BrowserAnimationsModule,
    SimpleNotificationsModule.forRoot(),

    AppRoutingModule,
    ApiModule
  ],
  declarations: [
    AppComponent,
    UserLogin, UserLogout,
    RequestsContainer, RequestList, RequestShow, RequestNew,
    MessageNew,
    LazyLoad, PageNotFoundComponent
  ],
  providers: [
    AuthGuard,
    CurrentUser
  ],
  bootstrap: [AppComponent]
})

export class AppModule { }
