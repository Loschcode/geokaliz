Template.MasterLayout.helpers {}

Template.MasterLayout.events {

  "click #become-focus": (event) ->

    Session.set('isFocusedOnMarker', true)

  "click #revoke-focus": (event) ->

    Session.set('isFocusedOnMarker', false)

}

