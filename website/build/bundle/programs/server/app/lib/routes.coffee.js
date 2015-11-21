(function(){

/////////////////////////////////////////////////////////////////////////
//                                                                     //
// lib/routes.coffee.js                                                //
//                                                                     //
/////////////////////////////////////////////////////////////////////////
                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Router.configure({                                                     // 1
  layoutTemplate: 'MasterLayout',                                      // 2
  loadingTemplate: 'Loading',                                          // 2
  notFoundTemplate: 'NotFound'                                         // 2
});                                                                    //
                                                                       //
Router.route('/', {                                                    // 1
  name: 'home',                                                        // 8
  controller: 'HomeController',                                        // 8
  where: 'client'                                                      // 8
});                                                                    //
                                                                       //
/////////////////////////////////////////////////////////////////////////

}).call(this);

//# sourceMappingURL=routes.coffee.js.map
