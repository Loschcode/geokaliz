(function(){

/////////////////////////////////////////////////////////////////////////
//                                                                     //
// lib/collections/targets.coffee.js                                   //
//                                                                     //
/////////////////////////////////////////////////////////////////////////
                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
this.Targets = new Mongo.Collection('targets');                        // 1
                                                                       //
if (Meteor.isServer) {                                                 // 3
  Targets.allow({                                                      // 5
    insert: function(targetId, doc) {                                  // 7
      return true;                                                     // 8
    },                                                                 //
    update: function(targetId, doc, fieldNames, modifier) {            // 7
      return true;                                                     // 11
    },                                                                 //
    remove: function(targetId, doc) {                                  // 7
      return true;                                                     // 14
    }                                                                  //
  });                                                                  //
  Targets.attachSchema(new SimpleSchema({                              // 5
    connectionId: {                                                    // 18
      type: String,                                                    // 19
      label: 'Connection ID',                                          // 19
      max: 100                                                         // 19
    },                                                                 //
    isActivated: {                                                     // 18
      type: Boolean,                                                   // 24
      label: 'Is Activated',                                           // 24
      defaultValue: false                                              // 24
    },                                                                 //
    name: {                                                            // 18
      type: String,                                                    // 29
      label: 'Name',                                                   // 29
      max: 100                                                         // 29
    },                                                                 //
    lat: {                                                             // 18
      type: Number,                                                    // 34
      label: 'Latitude',                                               // 34
      decimal: true                                                    // 34
    },                                                                 //
    lng: {                                                             // 18
      type: Number,                                                    // 39
      label: 'Longitude',                                              // 39
      decimal: true                                                    // 39
    }                                                                  //
  }));                                                                 //
}                                                                      //
                                                                       //
/////////////////////////////////////////////////////////////////////////

}).call(this);

//# sourceMappingURL=targets.coffee.js.map
