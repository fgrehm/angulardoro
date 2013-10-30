#= require jquery
#= require jquery-ui.custom
#= require angular
#= require angular-ui-sortable

app = angular.module('angulardoroApp', ['ui.sortable'])

@ActivitiesCtrl = ($scope, $rootScope, $http) ->
  # REFACTOR: Use AngularJS $resource
  $http.get('/api/activities').success (data) ->
    activities = data.activities
    # HACK: Mark the first activity as active and selected
    if activities[0]
      activities[0].active = true
      $rootScope.selectedActivity = activities[0]
    $scope.activities = activities

  lock = false
  sort = ->
    return if lock

    lock = true
    # TODO: Disable sorting while we save it
    data = activities: (activity.id for activity in $scope.activities)
    $http.put("api/activities/sort", data).
      success(-> lock = false).
      error(  -> lock = false)

  $scope.sortableOptions = {
    axis: 'y'
    stop: (e, ui) -> sort()
  }

  lock = false
  $scope.addActivity = ->
    return if (!$scope.newActivityName || lock)

    lock = true
    $http.post('api/activities', {activity: {name: $scope.newActivityName}}).
      success((data) ->
        $scope.activities.push(data.activity)
        if $scope.activities.length == 1
          $scope.selectActivity(data.activity)
        $scope.newActivityName = ''
        lock = false
      ).
      error(-> lock = false)

  $scope.selectActivity = (activity) ->
    $rootScope.selectedActivity?.active = false
    $rootScope.selectedActivity = activity
    activity.active = true


  $rootScope.$on 'activityRemoved', ->
    idx = $scope.activities.indexOf($rootScope.selectedActivity)
    idx-- if (idx + 1) == $scope.activities.length

    $scope.activities = $scope.activities.filter (a) -> a isnt $rootScope.selectedActivity

    nextActivity = $scope.activities
    $rootScope.selectedActivity = $scope.activities[idx]
    $rootScope.selectedActivity?.active = true

app.controller('ActivitiesCtrl', ['$scope', '$rootScope', '$http', @ActivitiesCtrl])


@ActivityCtrl = ($scope, $rootScope, $http) ->
  $scope.editorEnabled = false

  disableEditor = ->
    lock = false
    $scope.editorEnabled = false

  lock = false
  $scope.updateActivity = ->
    return if lock

    lock     = true
    activity = $rootScope.selectedActivity

    $http.put("api/activities/#{activity.id}", {activity: {name: activity.name}}).
      success(->
        lock = false
        $scope.editorEnabled = false
      ).
      error(-> lock = false)

  $scope.removeActivity = ->
    return if lock
    return unless confirm('Are you sure?')

    lock     = true
    activity = $rootScope.selectedActivity

    $http.delete("api/activities/#{activity.id}").
      success(->
        $rootScope.$emit('activityRemoved')
        lock = false
      ).
      error(-> lock = false)

app.controller('ActivityCtrl', ['$scope', '$rootScope', '$http', @ActivityCtrl])

# ng-hide="editorEnabled"
