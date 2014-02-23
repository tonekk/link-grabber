// Setup our model
Link = can.Model({
  findAll: 'GET /links',
  findOne: 'GET /links/{id}',
  create:  'POST /links',
  update:  'PUT /links/{id}',
  destroy: 'DELETE /links/{id}'
}, {

  // Checks for link validity
  // also starts completion process, if validity check succeeds
  isValid: function() {
    // Iterate trough all distributors and check for a regex match
    // then add embedded link to object
    for(key in Link.distributors) {
      if(Link.distributors.hasOwnProperty(key)) {
        distributor = Link.distributors[key];
        res = this.link.match(distributor.regex);
        if(res) {
          this.matches = res;
          this.distributor = distributor;
          return true;
        }
      }
    }
    return false;
  },

  // Get embedded link & name
  fetchData: function(matches, distributor) {
    this.distributor.getEmbeddedLink(this.matches);
    this.distributor.getName(this.matches);
  }
});

// Distributors of links that we want to add
Link.distributors = {
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
        success: function(data) {
          if(data.entry) {
            LinkGrabber.grabber.currentLink.attr('name', retVal = data.entry.title.$t);
          }
        },
        error: function() {
          LinkGrabber.grabber.displayInvalid();
        }
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
};
