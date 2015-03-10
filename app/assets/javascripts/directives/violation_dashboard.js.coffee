App.directive "violationDashboard", ["Violation", (Violation) ->
  scope: {}
  restrict: "E"
  templateUrl: "/templates/dashboard"

  link: (scope, element, attributes) ->
    loadData = ->
      violations = Violation.query()
      violations.$promise.then (results) ->
        scope.maxCount = d3.max(results, (d) -> d.count)
        scope.violations = results

    loadData()
]
