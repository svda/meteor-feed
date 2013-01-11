Package.describe({
  summary: "Display a live feed in your app."
});

Package.on_use(function (api) {
  api.use('http', 'server');
  api.use(['coffeescript', 'module'], ['client','server']);
  api.use('templating', 'less', 'client');

  api.add_files(['client.coffee'], 'client');
  api.add_files(['server.coffee'], 'server');

  // Instagram
  api.add_files(['feeds/instagram/instagram.less', 'feeds/instagram/instagram.html', 'feeds/instagram/client.coffee'], 'client');
  api.add_files(['feeds/instagram/server.coffee'], 'server');

  // Twitter ...

});
