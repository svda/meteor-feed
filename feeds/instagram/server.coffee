class InstagramFeedAPI extends FeedAPI

  constructor: (options) ->
    super()
    @routes.hash = /^photofeed\?(.*)hub.mode=subscribe(.*)?/