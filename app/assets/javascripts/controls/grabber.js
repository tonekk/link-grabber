Grabber = can.Control.extend({
  init: function(){

    var self = this;

    this.state = new can.Map({
      disabled: 'disabled',
      sign: 'off',
      inputVal: ''
    });

    this.element.html(can.view('views/grabberView.mustache', this.state));
  },

  // shows that input is valid
  displayValid: function() {
    this.state.attr('sign', 'ok');
  },

  // shows that input is invalid
  displayInvalid: function() {
    this.state.attr('sign', 'remove');
    this.toggleSaveButton(false);
  },

  // shows that input is empty
  displayEmpty: function() {
    this.state.attr('sign', 'off');
    this.toggleSaveButton(false);
  },

  // enables / disables save button
  toggleSaveButton: function(on) {
    this.state.attr('disabled', (on ? '' : 'disabled'));
  },

  // Clears input
  clear: function() {
    this.state.attr('inputVal', '');
    this.displayEmpty();
    this.currentLink = undefined;
  },

  '#grab-me keyup': function(el, e) {

    this.state.attr('inputVal', $('#grab-me').val());
    var currentInput = this.state.attr('inputVal');
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
