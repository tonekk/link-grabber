Grabber = can.Control({
  init: function(){
    this.element.html(can.view('views/grabberView.mustache', {
    }));
  },

  // shows that input is valid
  displayValid: function() {
    $('#grabber .is-valid').removeClass('glyphicon-off glyphicon-remove')
                            .addClass('glyphicon-ok');
  },

  // shows that input is invalid
  displayInvalid: function() {
    $('#grabber .is-valid').removeClass('glyphicon-off glyphicon-ok')
                            .addClass('glyphicon-remove');
    this.toggleSaveButton(false);
  },

  // shows that input is empty
  displayEmpty: function() {
    $('#grabber .is-valid').removeClass('glyphicon-remove glyphicon-ok')
                            .addClass('glyphicon-off');
    this.toggleSaveButton(false);
  },

  // enables / disables save button
  toggleSaveButton: function(on) {
    $('#grabber button.save').attr('disabled', !on);
  },

  // Clears input
  clear: function() {
    $('#grabber #grab-me').val('');
    this.displayEmpty();
    this.currentLink = undefined;
  },

  '#grab-me keyup': function(el, e) {
    var currentInput = $(e.currentTarget).val();
    var self = this;

    if(currentInput == "") {
      this.displayEmpty();
      return;
    }

    var link = new Link({link: currentInput});

    // If link is valid, display valid glyphicon and enable save button
    if(link.isValid()) {
      this.displayValid();
      this.currentLink = link;
      this.currentLink.bind('change', function(ev, attr, how, newVal, oldVal) {
        if(this.attr('embedded_link') && this.attr('name')) {
          self.toggleSaveButton(true);
        }
      });

      this.currentLink.fetchData();
    }

    // If not, display invalid glyphicon
    else {
      this.displayInvalid();
    }
  },

  'button.save click': function(el, e) {
    if(this.currentLink) {
      // Push our new link to the database
      this.currentLink.save();
      // update the view
      LinkGrabber.linkList.links.push(this.currentLink);
    }
    this.clear();
  }
});
