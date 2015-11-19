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

  myTarget: =>

    return Targets.findOne({_id: Session.get('myTargetId')})

  isFocusedOnMarker: =>

    return Session.get('isFocusedOnMarker')

}

# Home: Lifecycle Hooks
Template.Home.onCreated ->

Template.Home.onRendered ->

Template.Home.onDestroyed ->