@HomeController = RouteController.extend(
  
  # A place to put your subscriptions
  # this.subscribe('items');
  # # add the subscription to the waitlist
  # this.subscribe('item', this.params._id).wait();
  
  subscriptions: ->

    @subscribe('allTargets')

  # Subscriptions or other things we want to "wait" on. This also
  # automatically uses the loading hook. That's the only difference between
  # this option and the subscriptions option above.
  # return Meteor.subscribe('post', this.params._id);
  
  waitOn: ->
  
  # A data function that can be used to automatically set the data context for
  # our layout. This function can also be used by hooks and plugins. For
  # example, the "dataNotFound" plugin calls this function to see if it
  # returns a null value, and if so, renders the not found template.
  # return Posts.findOne({_id: this.params._id});
  
  data: ->

  # You can provide any of the hook options
  
  onRun: ->

    @next()

  onRerun: ->

    @next()

  onBeforeAction: ->

    # We load GoogleMaps
    GoogleMaps.load()

    #random_id = Random.id()
    #random_username = "Anonymous #{random_id}"
    #random_email = "anonymous#{random_id}@anonymous.com"

    # We create a temporary account
    #Accounts.createUser {

    #  username: random_username
    #  email: random_email
    #  password: 'anonymous'
    #  profile: {name: 'Anonymous'}

    #}, (errorUser) ->

      #if !errorUser
        # Nothing
    
    @next()


  # The same thing as providing a function as the second parameter. You can
  # also provide a string action name here which will be looked up on a Controller
  # when the route runs. More on Controllers later. Note, the action function
  # is optional. By default a route will render its template, layout and
  # regions automatically.
  # Example:
  #  action: 'myActionFunction'
  
  action: ->

    @render()

  onAfterAction: ->

  onStop: ->

)
