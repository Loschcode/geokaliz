Meteor.startup ->

  console.log('Find me in server/bootstrap.coffee')
  console.log('Removing all the targets and users ...')

  Targets.remove({})
  Meteor.users.remove({})

  console.log('Targets and Users removed.')