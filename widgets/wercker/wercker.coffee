class Dashing.Wercker extends Dashing.Widget
  constructor: ->
    super

    @statusClassnames = "status-notstarted status-started status-running status-unknown";
    @resultClassnames = "result-passed result-failed result-aborted result-unknown";

  refreshWidgetState: =>
    node = $(@node)
    className = @get('class_name').toLowerCase()
    node.removeClass(@statusClassnames)
    node.removeClass(@resultClassnames)
    node.addClass(className)

  ready: ->
    @refreshWidgetState()

  onData: (data) ->
    @refreshWidgetState()
