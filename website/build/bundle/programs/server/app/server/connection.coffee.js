(function(){

/////////////////////////////////////////////////////////////////////////
//                                                                     //
// server/connection.coffee.js                                         //
//                                                                     //
/////////////////////////////////////////////////////////////////////////
                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Meteor.onConnection(function(connection) {                             // 1
  return connection.onClose(function() {                               //
    return Targets.remove({                                            //
      connectionId: connection.id                                      // 5
    });                                                                //
  });                                                                  //
});                                                                    // 1
                                                                       //
/////////////////////////////////////////////////////////////////////////

}).call(this);

//# sourceMappingURL=connection.coffee.js.map
