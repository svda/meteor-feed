class FeedAPI

  constructor: () ->
    @_url = __meteor_bootstrap__.require('url')
    @_querystring = __meteor_bootstrap__.require('querystring')
    @routes =
        hash: /^feed\?(.*)hub.mode=subscribe(.*)?/
        handler: @subscribe

  subscribe: (request, response) ->
    new FeedAPI._requestListener(self, request, response)

class FeedAPI::_requestListener

  constructor: () ->

  _sendResponse: (statusCode, body) ->
    @_response.statusCode = statusCode
    @_response.setHeader('Content-Length', body.length)
    @_response.setHeader('Content-Type', 'application/json')
    @_response.write(body)
    @_response.end()

Meteor.methods
  fetchRecentImages: (client_id, options) ->
    url = 'https://api.instagram.com/v1/tags/' + options.tags + '/media/recent'
    result = Meteor.http.get(url,
      params:
        client_id: client_id
      timeout: 30000
    )
    if result.statusCode == 200 
      result.data
    else
      console.log('Error in fetchRecentPhotos: ', result.statusCode)
      throw new Meteor.Error(result.statusCode, result.error);