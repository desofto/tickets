import { Injectable }     from '@angular/core';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import { CurrentUser } from '../services/index';
import { Md5 } from 'ts-md5/dist/md5';
import 'rxjs/add/operator/map';

@Injectable()

// API for access user
// We are using promises instead of observable here because there are one time events

export class UserApi {
  constructor (
    private http: Http,
    private currentUserService: CurrentUser
  ) {
  }

  // try to login on backend and store retrived information in the user storage
  login(email: string, password: string) {
    return new Promise((resolve, reject) => {
      const headers = new Headers({ 'Content-Type': 'application/x-www-form-urlencoded' });
      const options = new RequestOptions({ headers: headers });
      const body: URLSearchParams = new URLSearchParams();
      body.set('email', email);
      body.set('password', password);

      this.http.post('/api/v1/sign_in', body.toString(), options)
        .subscribe((response: Response) => {
          // login successful if there are both correct status and session id
          let user = response.json();
          if(user && user.auth_token) {
            // store user details in local storage to keep user logged in between page refreshes
            this.currentUserService.set(user);
            resolve();
          }
        });
    });
  }

  // clear current user info in the user storeage and tries to logout on backend
  logout() {
    return new Promise((resolve, reject) => {
      let auth_token = this.currentUserService.active.auth_token;
      // remove user from local storage to log user out
      this.currentUserService.clear();
      this.http.delete(`/api/v1/sign_out?auth_token=${auth_token}`).subscribe(() => resolve());
    });
  }
}
