@Targets = new Mongo.Collection('targets')

if Meteor.isServer

  Targets.allow

    insert: (targetId, doc) ->
      return true

    update: (targetId, doc, fieldNames, modifier) ->
      return true

    remove: (targetId, doc) ->
      return true

  Targets.attachSchema new SimpleSchema(

    connectionId:
      type: String
      label: 'Connection ID'
      max: 100

    isActivated:
      type: Boolean
      label: 'Is Activated'
      defaultValue: false
      
    name:
      type: String
      label: 'Name'
      max: 100

    lat:
      type: Number
      label: 'Latitude'
      decimal: true
      
    lng:
      type: Number
      label: 'Longitude'
      decimal: true

    )
