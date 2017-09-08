import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AppComponent }         from './app.component';
import { UserLogin, UserLogout }  from './user/index';
import { AuthGuard }              from './guards/index';
import { PageNotFoundComponent } from './shared/index';

const appRoutes: Routes = [
  { path: '', component: AppComponent, pathMatch: 'full' }, //, canActivate: [AuthGuard] },
  { path: 'login', component: UserLogin },
  { path: 'logout', component: UserLogout },
  { path: '**', component: PageNotFoundComponent }
];

@NgModule({
  imports: [
    RouterModule.forRoot(appRoutes)
  ],
  exports: [
    RouterModule
  ],
  providers: [
  ]
})
export class AppRoutingModule { }
