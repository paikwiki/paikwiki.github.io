ga('create', 'UA-115101412-1', 'auto');

function clickABookLink(event) {
  ga('send', 'event', {
    eventCategory: 'Aladin TTB2',
    eventAction: 'click',
    eventLabel: title
  });
}

function addABookTracker(link) {
  var url = link.getAttribute('href');
  if ( url.search('ttbkey') ) {
    link.addEventListener('click', function(e) {
      clickABookLink(e);
    });
  }
}

var links = document.querySelectorAll('a');
links.forEach(function(i) {
  addABookTracker(i);
});
