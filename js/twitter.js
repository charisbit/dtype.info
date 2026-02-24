var twitter = (function() {
  function render(target) {
    var fragment = '<li><i class="fa fa-twitter"></i><a href="https://twitter.com/charisbit" target="_blank">@charisbit</a><p>Follow on Twitter</p></li>';
    $(target)[0].innerHTML = fragment;
  }
  return {
    showTweets: function(options) {
      // Use Twitter native embed
      var twitterHtml = '<a class="twitter-timeline" href="https://twitter.com/charisbit?ref_src=twsrc%5Etfw">Tweets by @charisbit</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"><\/script>';
      $(options.target).html(twitterHtml);
    }
  };
})();
