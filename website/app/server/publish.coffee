#
# Get all the targets
#
Meteor.publish 'allTargets', ->

  return Targets.find()