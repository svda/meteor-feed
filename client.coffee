do() ->

  module = c2o.Module.instance()
  module.register 'feed'

  Meteor.Router.add
    '/twitterfeed': 'twitterfeed'
    '/instagramfeed': 'instagramfeed'
