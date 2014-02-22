LinkList = can.Control({
  init: function(){
    var self = this;
    // Fetch all of the links from the db and put them into the view
    Link.findAll({}, function(links) {
      self.links = links;
      self.element.html(can.view('views/linkListView.mustache', {links: self.links}));
    });
  },
  'li.not-loaded click': function(el, e) {
    $li = $(e.currentTarget)

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
  },
  'iframe load': function(el, e) {
    self.loadIframes();
  }
});
