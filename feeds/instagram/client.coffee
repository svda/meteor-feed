do () ->

  class InstagramFeed

    @ITEMS_SESSION_KEY: 'instagramfeed.images' # static (bound to the object itself, not the prototype)

    constructor: (@clientId, @options) ->
      Session.set(InstagramFeed.ITEMS_SESSION_KEY, null)
      @items = []
      @update()

    _addItem: (id, url) -> # private
      @items.unshift({ id: id, url: url }) if not _.find @items, (item) -> item.id == id

    update: () ->
      Meteor.call 'fetchRecentImages', @clientId, @options, (error, response) => # FAT
        if error
          console.log 'Error occured while receiving data on server. ', error
        else
          response.data.forEach (item) => @_addItem item.id, item.images.thumbnail.url
          Session.set InstagramFeed.ITEMS_SESSION_KEY, @items

  feed = new InstagramFeed '4dabf37a25934bd4bc61c1d9845536c2', { tags: 'woman' }

  Template.instagramfeed.created = () ->
    Meteor.setInterval ->
      feed.update()
    , 10000

  Template.instagramfeed.images = () -> Session.get InstagramFeed.ITEMS_SESSION_KEY

_.uniqObjects = (arr) ->
  j = _.uniq( _.map( arr, (x) ->
    JSON.stringify x
  ))
