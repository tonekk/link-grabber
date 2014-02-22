// Setup our model
Link = can.Model({
  findAll: 'GET /links',
  findOne: 'GET /links/{id}',
  create:  'POST /links',
  update:  'PUT /links/{id}',
  destroy: 'DELETE /links/{id}'
}, {

  isValid: function() {
    // Iterate trough all distributors and check for a regex match
    // then add embedded link to object
    for(key in Link.distributors) {
      if(Link.distributors.hasOwnProperty(key)) {
        distributor = Link.distributors[key];
        res = this.link.match(distributor.regex);
        if(res) {
          this.attr('embedded_link', distributor.getEmbeddedLink(res));
          this.attr('name', distributor.getName(res));
          return true;
        }
      }
    }
    return false;
  },
});

// Distributors of links that we want to add
Link.distributors = {
  youtube: {
    // NOTE: This regex should be improved!
    regex: RegExp("(?:https?:)?\/\/(?:www\.)?(?:youtube\.com\/watch[?]v=|youtu\.be\/)([a-zA-Z0-9]+)(?:&.*)?"),
    getEmbeddedLink: function(matches) {
      return "//www.youtube.com/embed/"+matches[1];
    },
    getName: function(matches) {
      var retVal = "";
      $.ajax({
        url: 'https://gdata.youtube.com/feeds/api/videos/'+matches[1]+'?v=2&alt=json',
        async: false,
        success: function(data) {
          if(data.entry) {
            retVal = data.entry.title.$t;
          }
        }
      });
      return retVal;
    }
  }
};
