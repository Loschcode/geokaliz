#
# Events
#
Template.GeolocationMap.events {

}

#
# Helpers
#
Template.GeolocationMap.helpers {

  # Check whether google maps is loaded or not
  googleMapsLoaded: =>

    return GoogleMaps.loaded()

  myMarkerIsPlaced: =>

    if Session.get('myTargetId')
      return true
    else
      return false

  # Error if any on map loading
  geolocationMapError: =>

    #
    # Geolocation is very UNSTABLE
    # It might shows an error and right after not make this error anymore
    # Therefore we never consider errors
    #
    if Session.get('geolocationEnabled')
      return false

    error = Geolocation.error()

    # 
    # If there's any error or the uptime is more than 10 seconds and
    # The geolocation isn't set as enabled - sometimes it's a silent system with the phones
    # 
    if (error and error.message) or (Session.get("uptime") > 30)

      # 
      # If it's not already displayed
      # 
      # NOTE : This system will be re-read every second since it calls Session.get("uptime")
      # I made the choice not to clearInterval in case the user changes his geolocation settings
      # And let the app up
      # 
      unless Session.get('lastLoader') == 'geolocation_error'

        # If there's any error showing up before
        IonLoading.hide()

        # Error shows up
        Session.set('lastLoader', 'geolocation_error')
        IonLoading.show({
          customTemplate: "<h3>Oops !</h3><p>We weren't able to retrieve the map details.<br />Please enable geolocation and restart Geokaliz.</p> (`#{error.message}`)",
          backdrop: true
        });

    else

      # We hide the loader only if it was previously a geolocation error
      # Otherwise it would cut the other loaders constantly
      if Session.get('lastLoader') == 'geolocation_error'
        IonLoading.hide()

    return error and error.message

  # Geolocation Map Options on loading
  geolocationMapOptions: =>

    latLng = Geolocation.latLng()

    # Initialize the map once we have the latLng.
    if GoogleMaps.loaded() and latLng

      Session.set('geolocationEnabled', true)

      if Meteor.isCordova

        return {

          center: new google.maps.LatLng(latLng.lat, latLng.lng)
          zoom: Meteor.settings.public.MAP_ZOOM

          styles: [{"stylers":[{"saturation":-100},{"gamma":1}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"poi.place_of_worship","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.place_of_worship","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry","stylers":[{"visibility":"simplified"}]},{"featureType":"water","stylers":[{"visibility":"on"},{"saturation":50},{"gamma":0},{"hue":"#50a5d1"}]},{"featureType":"administrative.neighborhood","elementType":"labels.text.fill","stylers":[{"color":"#333333"}]},{"featureType":"road.local","elementType":"labels.text","stylers":[{"weight":0.5},{"color":"#333333"}]},{"featureType":"transit.station","elementType":"labels.icon","stylers":[{"gamma":1},{"saturation":50}]}]        
          
          disableDefaultUI: true
          mapTypeControl: false
          scaleControl: false
          zoomControl: false

        }

      else

        return {

          center: new google.maps.LatLng(latLng.lat, latLng.lng)
          zoom: Meteor.settings.public.MAP_ZOOM

          styles: [{"stylers":[{"saturation":-100},{"gamma":1}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"poi.place_of_worship","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.place_of_worship","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry","stylers":[{"visibility":"simplified"}]},{"featureType":"water","stylers":[{"visibility":"on"},{"saturation":50},{"gamma":0},{"hue":"#50a5d1"}]},{"featureType":"administrative.neighborhood","elementType":"labels.text.fill","stylers":[{"color":"#333333"}]},{"featureType":"road.local","elementType":"labels.text","stylers":[{"weight":0.5},{"color":"#333333"}]},{"featureType":"transit.station","elementType":"labels.icon","stylers":[{"gamma":1},{"saturation":50}]}]        
          
          disableDefaultUI: true
          mapTypeControl: false
          scaleControl: true
          zoomControl: true

        }
}

#
# onCreated
#
Template.GeolocationMap.onCreated =>

  # Uptime from creation
  uptime_system = ->

    if !Session.get("uptime")
      Session.set("uptime", 0)

    Session.set("uptime", (Session.get("uptime")+1))

  Meteor.setInterval(uptime_system, 1000)

  Session.get('geolocationEnabled', false)

  # When it's ready, we process the position
  GoogleMaps.ready 'MainMap', (googleMap) =>

    # We get the MapsManager library
    @MapsManager = new MapsManager(googleMap)

    # We hide the loader
    IonLoading.hide()

    # Default is focused
    Session.set('isFocusedOnMarker', true)

    # Event DragStart triggered
    @MapsManager.googleMap.instance.addListener 'dragstart', ->

      # When we move the map, we don't focus anymore
      Session.set('isFocusedOnMarker', false)

    Targets.find().observe({
        
      added: (target) =>

        @MapsManager.addMarkerFromTarget(target)

        console.log('TARGET ADDED : ' + target._id)
        console.log(Targets.find().fetch())

      changed: (target) =>

        @MapsManager.addOrUpdateMarkerFromTarget(target)

        console.log('TARGET CHANGED : ' + target._id)
        console.log(Targets.find().fetch())

      removed: (target) =>

        @MapsManager.removeMarkerFromTarget(target)

        console.log('TARGET REMOVED : ' + target._id)
        console.log(Targets.find().fetch())

    });

    # Create and move the marker when latLng changes.
    Tracker.autorun =>

      # LatLng
      myLatLng = Geolocation.latLng()

      if !myLatLng
        return

      # 
      # Our target already exists
      # We just have to refresh the position in the database
      # 
      if Session.get('myTargetId')

        Targets.update(Session.get('myTargetId'), {

          $set: {

            lat: myLatLng.lat,
            lng: myLatLng.lng

          }

        });

      # 
      # We insert the new target from our position
      # If it's not already defined
      # 
      else

        Session.set('myTargetId', Targets.insert({

          connectionId: Meteor.default_connection._lastSessionId
          name: "Lambda name",
          lat: myLatLng.lat,
          lng: myLatLng.lng

        }))

      # If it's our target, we auto-center and possibility zoom again
      myTarget = Targets.findOne({_id: Session.get('myTargetId')})

      if myTarget
        @MapsManager.centerMyMarkerIfFocused(myTarget)

#
# onRendered
#
Template.GeolocationMap.onRendered ->

#
# onDestroyed
#
Template.GeolocationMap.onDestroyed ->