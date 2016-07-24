define('search', [], function() {
  function Search() {
    this.input = $('#search');

    this._bindEvents();
  };

  var fn = Search.prototype;

  fn._bindEvents = function() {
    this.input.focus();
    this.input.on('keyup', $.proxy(this._searchWord, this));
  };

  fn._searchWord = function(e) {
    var enterKeyCode = 13;
    if (e.keyCode === enterKeyCode) {
      $('body').removeClass('loaded');
    }
  };

  return Search;
})
