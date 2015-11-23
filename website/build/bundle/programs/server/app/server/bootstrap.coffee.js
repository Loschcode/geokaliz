(function(){

/////////////////////////////////////////////////////////////////////////
//                                                                     //
// server/bootstrap.coffee.js                                          //
//                                                                     //
/////////////////////////////////////////////////////////////////////////
                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Meteor.startup(function() {                                            // 1
  console.log('Find me in server/bootstrap.coffee');                   // 3
  console.log('Removing all the targets and users ...');               // 3
  Targets.remove({});                                                  // 3
  Meteor.users.remove({});                                             // 3
  return console.log('Targets and Users removed.');                    //
});                                                                    // 1
                                                                       //
/////////////////////////////////////////////////////////////////////////

}).call(this);

//# sourceMappingURL=bootstrap.coffee.js.map
