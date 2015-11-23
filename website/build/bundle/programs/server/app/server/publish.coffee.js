(function(){

/////////////////////////////////////////////////////////////////////////
//                                                                     //
// server/publish.coffee.js                                            //
//                                                                     //
/////////////////////////////////////////////////////////////////////////
                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Meteor.publish('allTargets', function() {                              // 4
  return Targets.find();                                               // 6
});                                                                    // 4
                                                                       //
/////////////////////////////////////////////////////////////////////////

}).call(this);

//# sourceMappingURL=publish.coffee.js.map
