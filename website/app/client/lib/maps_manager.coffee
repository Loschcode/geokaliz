class @MapsManager

  allMarkers: {}
  googleMap: null

  constructor: (googleMap) ->

    @googleMap = googleMap

  isMyTarget: (target) ->

    return target._id is Session.get('myTargetId')

  centerMyMarkerIfFocused: (target) ->

    if @isMyTarget(target)

      if Session.get('isFocusedOnMarker')

        marker = @getMarkerFromTarget(target)
        @googleMap.instance.setCenter marker.getPosition()
        #map.instance.setZoom @MAP_ZOOM only if we want to always zoom at the same

  setMarkerFromTarget: (target, marker) =>

    @allMarkers[target._id] = marker

    return @allMarkers[target._id]

  getMarkerFromTarget: (target) =>

    if @allMarkers[target._id]?

      return @allMarkers[target._id]

    else

      return false

  guessColorFromTarget: (target) ->

    if target.isActivated

      return 'green'

    else

      if @isMyTarget(target)

        return 'blue'

      else

        return 'red'

  makeMarkerImage: (color) ->

    if color is 'red'

      MarkerImage = {

        path: google.maps.SymbolPath.CIRCLE,
        fillOpacity: 0.8,
        fillColor: '#e74c3c',
        strokeOpacity: 1.0,
        strokeColor: '#c0392b',
        strokeWeight: 3.0, 
        scale: 14

      }

    else if color is 'blue'

      MarkerImage = {

        path: google.maps.SymbolPath.CIRCLE,
        fillOpacity: 0.8,
        fillColor: '#3498db',
        strokeOpacity: 1.0,
        strokeColor: '#2980b9',
        strokeWeight: 3.0, 
        scale: 16

      }

    else if color is 'green'

      MarkerImage = {

        path: google.maps.SymbolPath.CIRCLE,
        fillOpacity: 0.8,
        fillColor: '#2ecc71',
        strokeOpacity: 1.0,
        strokeColor: '#27ae60',
        strokeWeight: 3.0, 
        scale: 18

      }

    else

      MarkerImage = {

        path: google.maps.SymbolPath.CIRCLE,
        scale: 20

      }

    return MarkerImage

  makeMarker: (latLng, MarkerImage) =>

    myMarker = new (google.maps.Marker)(
      position: new (google.maps.LatLng)(latLng.lat, latLng.lng)
      icon: MarkerImage
      map: @googleMap.instance)

  addMarkerFromTarget: (target) =>

    MarkerImage = @makeMarkerImage(@guessColorFromTarget(target))
    Marker = @makeMarker({lat: target.lat, lng: target.lng}, MarkerImage)

    @setMarkerFromTarget(target, Marker)

  removeMarkerFromTarget: (target) =>

    Marker = @getMarkerFromTarget(target)
    Marker.setMap(null)

  addOrUpdateMarkerFromTarget: (target) =>

    Marker = @getMarkerFromTarget(target)

    if !Marker

      @addMarkerFromTarget(target)

    else

      Marker.setPosition {lat: target.lat, lng: target.lng}
      MarkerImage = @makeMarkerImage(@guessColorFromTarget(target))
      Marker.setIcon MarkerImage
