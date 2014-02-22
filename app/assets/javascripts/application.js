//= require jquery
//= require bootstrap

//= require vendor/modernizr.min
//= require vendor/can.jquery

//= require models/link

//= require controls/grabber
//= require controls/linkList


// Application Singleton
window.LinkGrabber = {};

$(function() {
  // Create our views
  LinkGrabber.grabber = new Grabber('#grabber', {});
  LinkGrabber.linkList = new LinkList('#link-list');
});

