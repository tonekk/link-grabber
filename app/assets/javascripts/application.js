//= require jquery
//= require bootstrap

//= require vendor/modernizr.min
//= require vendor/can.jquery

//= require models/link

//= require controls/grabber
//= require controls/linkList


// Application Singleton
window.LinkGrabber = {

  // Distributors of links that we want to add
  distributors: {
    youtube: {
      // NOTE: This regex should be improved!
      regex: RegExp("(?:https?:)?\/\/(?:www\.)?(?:youtube\.com\/watch[?]v=|youtu\.be\/)([a-zA-Z0-9\-_]+)(?:&.*)?"),
      getEmbeddedLink: function(matches) {
        LinkGrabber.grabber.currentLink.attr('embedded_link', "//www.youtube.com/embed/"+matches[1]);
      },
      getName: function(matches) {
        $.ajax({
          url: 'https://gdata.youtube.com/feeds/api/videos/'+matches[1]+'?v=2&alt=json',
          // This is the real validity check
        }).then(function(data) {
          if(data.entry) {
            LinkGrabber.grabber.currentLink.attr('name', retVal = data.entry.title.$t);
          }
        },
        function() {
          LinkGrabber.grabber.displayInvalid();
        });
      }
    },

    soundcloud: {
      // NOTE: This regex should be improved!
      regex: RegExp("((?:https?:)?\/\/(?:www\.)?(?:soundcloud\.com\/)[a-zA-Z0-9\-_\/]+)"),
      // Actually we get both name and embedded link here
      // so we only have to request SC API once.
      getEmbeddedLink: function(matches) {
        var retVal = "";
        SC.get('/resolve', { url: matches[1] }, function(track, error) {
          // This is the real validity check
          if(!error) {
            LinkGrabber.grabber.currentLink.attr('embedded_link', "https://w.soundcloud.com/player/?url="+encodeURIComponent(track.uri));;
            LinkGrabber.grabber.currentLink.attr('name', track.title);;
          }
          else {
            LinkGrabber.grabber.displayInvalid();
          }
        });
      },
      getName: function(matches) {
      }
    }
  }
};

$(function() {
  // Create our views
  LinkGrabber.grabber = new Grabber('#grabber', {});
  LinkGrabber.linkList = new LinkList('#link-list');
});

