describe "ActivitiesCtrl", ->
  $fixture     = {
    activities: [
      { id: 1, name: "Write a blog post" },
      { id: 2, name: "Learn about last week's buzzword" }
    ]
  }
  $scope       = null
  $controller  = null
  $httpBackend = null

  beforeEach module('angulardoroApp')

  beforeEach inject ($injector) ->
    $scope       = $injector.get('$rootScope').$new()
    $controller  = $injector.get('$controller')
    $httpBackend = $injector.get('$httpBackend')
    $httpBackend.when('GET','/api/activities').respond($fixture)

  it 'lists activities after index request', ->
    $controller(ActivitiesCtrl, {$scope: $scope})
    expect($scope.activities).toBeUndefined()
    $httpBackend.flush()
    expect($scope.activities.length).toBe 2
    expect($scope.activities).toEqual $fixture.activities

  # TODO: Don't be shy to rename the spec, this is just is reminder :)
  it 'sets the selectedActivity after loading list'
  it 'creates activities using the API'
  it 'selects activities'
