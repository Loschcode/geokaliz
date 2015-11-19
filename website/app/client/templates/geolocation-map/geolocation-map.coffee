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

    error = Geolocation.error()
    return error and error.message

  # Geolocation Map Options on loading
  geolocationMapOptions: =>

    latLng = Geolocation.latLng()

    # Initialize the map once we have the latLng.
    if GoogleMaps.loaded() and latLng

      return {

        center: new google.maps.LatLng(latLng.lat, latLng.lng)
        zoom: Meteor.settings.public.MAP_ZOOM

        styles: [{"stylers":[{"saturation":-100},{"gamma":1}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"poi.place_of_worship","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.place_of_worship","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry","stylers":[{"visibility":"simplified"}]},{"featureType":"water","stylers":[{"visibility":"on"},{"saturation":50},{"gamma":0},{"hue":"#50a5d1"}]},{"featureType":"administrative.neighborhood","elementType":"labels.text.fill","stylers":[{"color":"#333333"}]},{"featureType":"road.local","elementType":"labels.text","stylers":[{"weight":0.5},{"color":"#333333"}]},{"featureType":"transit.station","elementType":"labels.icon","stylers":[{"gamma":1},{"saturation":50}]}]        
        
        disableDefaultUI: true,
        mapTypeControl: false,
        scaleControl: false,
        zoomControl: false,

      }

}

#
# onCreated
#
Template.GeolocationMap.onCreated =>

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

  # General map loading
  IonLoading.show({
    customTemplate: '<h3>Loading…</h3><p>We are retrieving the map details ...</p>',
  });

#
# onDestroyed
#
Template.GeolocationMap.onDestroyed ->