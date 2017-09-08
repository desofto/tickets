import { NgModule }         from '@angular/core';
import { Router }           from '@angular/router';
import { BrowserModule }    from '@angular/platform-browser';
import { FormsModule }      from '@angular/forms';

import { AppRoutingModule } from './app.routing.module';
import { AppComponent }     from './app.component';

import { PageNotFoundComponent } from './shared/index';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,

    AppRoutingModule
  ],
  declarations: [
    AppComponent,
    PageNotFoundComponent
  ],
  providers: [],
  bootstrap: [AppComponent]
})

export class AppModule { }
