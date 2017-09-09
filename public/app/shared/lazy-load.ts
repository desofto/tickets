import { Component, OnInit, Output, EventEmitter, HostListener, ElementRef } from '@angular/core';

// Template for wrong url

@Component({
  selector: 'lazy-load',
  template: ''
})

export class LazyLoad implements OnInit {
  @Output('visible') load = new EventEmitter();

  constructor(
    private el: ElementRef
  ) { }

  ngOnInit() {
    this.onScrollEvent(null);
  }

  checkVisible(el: any) {
    var rect = el.getBoundingClientRect();
    var viewHeight = Math.max(document.documentElement.clientHeight, window.innerHeight);
    return !(rect.bottom < 0 || rect.top - viewHeight > 0);
  }

  @HostListener('window:scroll', ['$event']) onScrollEvent($event: any) {
    if(this.checkVisible(this.el.nativeElement)) {
      this.load.emit();
    }
  }
}
