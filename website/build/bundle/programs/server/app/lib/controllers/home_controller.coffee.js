(function(){

/////////////////////////////////////////////////////////////////////////
//                                                                     //
// lib/controllers/home_controller.coffee.js                           //
//                                                                     //
/////////////////////////////////////////////////////////////////////////
                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
this.HomeController = RouteController.extend({                         // 1
  subscriptions: function() {                                          // 8
    return this.subscribe('allTargets');                               //
  },                                                                   //
  waitOn: function() {},                                               // 8
  data: function() {},                                                 // 8
  onRun: function() {                                                  // 8
    return this.next();                                                //
  },                                                                   //
  onRerun: function() {                                                // 8
    return this.next();                                                //
  },                                                                   //
  onBeforeAction: function() {                                         // 8
    GoogleMaps.load();                                                 // 40
    return this.next();                                                //
  },                                                                   //
  action: function() {                                                 // 8
    return this.render();                                              //
  },                                                                   //
  onAfterAction: function() {},                                        // 8
  onStop: function() {}                                                // 8
});                                                                    //
                                                                       //
/////////////////////////////////////////////////////////////////////////

}).call(this);

//# sourceMappingURL=home_controller.coffee.js.map
