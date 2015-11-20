Template.Home.events {

  "click #become-target": (event) ->

    Targets.update(Session.get('myTargetId'), {

      $set: {isActivated: true}

    });

  "click #revoke-target": (event) ->

    Targets.update(Session.get('myTargetId'), {

      $set: {isActivated: false}

    });

}

Template.Home.helpers {

  peopleOnMapCounter: =>

    return Targets.find().count()

  myTarget: =>

    return Targets.findOne({_id: Session.get('myTargetId')})

  isFocusedOnMarker: =>

    return Session.get('isFocusedOnMarker')

}

# Home: Lifecycle Hooks
Template.Home.onCreated ->

  # General map loading
  IonLoading.show({
    customTemplate: '<h3>Loading…</h3><p>We are retrieving the map details ...</p>',
  })

Template.Home.onRendered ->

Template.Home.onDestroyed ->