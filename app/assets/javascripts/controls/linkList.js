LinkList = can.Control.extend({
  init: function(){
    var self = this;
    // Fetch all of the links from the db and put them into the view
    Link.findAll({}, function(links) {
      self.links = links;
      self.element.html(can.view('views/linkListView.mustache', {links: self.links}));
    });
  },
  'li.not-loaded click': function(el, e) {

    // NOTE: Is it really better to use live bindings here?
    // IMO its just making stuff really complicated

    var $li = $(el);

    // Remove class to unbind event
    $li.removeClass('not-loaded');

    // Hide link, show loading gif
    $li.find('.loading-wrapper').show();
    $li.find('span.text').hide();

    $iframe = $li.find('iframe');

    $iframe.attr('src', $iframe.attr('data-src'));

    // when iframe is loaded, display it
    $iframe.load(function() {
      $iframe.parent().fadeIn();
      $iframe.parent().parent().find('.loading-wrapper').hide();
    });
  }
});
