# Description:
#   Geocode Addresses and return a Latitude and Longitude using Googles Geocode API
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot geocode me <string> - Geocodes the string and return latitude,longitude
#   hubot where is <string> - Geocodes the string and return latitude,longitude
#
# Author:
#   mattheath (Original Author)
#   dy-dx (Contributor)
#   Milad-Soufastai (Added to NPM)

module.exports = (robot) ->
  robot.respond /geocode me (.*)/i, (res) ->
    query = res.match[1]
    geocodeMe res, encodeURI(query), (text) ->
      res.reply text
  robot.respond /where is (.*)/i, (res) ->
    query = res.match[1]
    geocodeMe res, encodeURI(query), (text) ->
      res.reply text

geocodeMe = (res, query, cb) ->
  res.http("https://maps.googleapis.com/maps/api/geocode/json?address=#{query}&sensor=false")
    .header('Accept', 'application/json')
    .get() (err, res, body) ->
      response = JSON.parse(body)
      return cb "No idea. Tried using a map? https://maps.google.com/" unless response.results?.length

      location = response.results[0].geometry.location.lat + "," + response.results[0].geometry.location.lng
      cb "That's somewhere around " + location + " - https://maps.google.com/maps?q=" + location