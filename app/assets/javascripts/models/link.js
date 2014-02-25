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
    var retVal = false;
    var self = this;
    $.each(LinkGrabber.distributors, function(distributorName, distributor) {
      var res = self.link.match(distributor.regex);
      if(res) {
        self.matches = res;
        self.distributor = distributor;
        retVal = true;
      }
    });
    return retVal;
  },

  // Get embedded link & name
  fetchData: function(matches, distributor) {
    this.distributor.getEmbeddedLink(this.matches);
    this.distributor.getName(this.matches);
  }
});
