Meteor.onConnection (connection) ->

  connection.onClose ->
    
    Targets.remove({connectionId: connection.id})