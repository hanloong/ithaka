###* @jsx React.DOM ###

token = $( 'meta[name="csrf-token"]').attr('content')

$.ajaxSetup
  beforeSend: ( xhr ) ->
    xhr.setRequestHeader( 'X-CSRF-Token' ,token )

@InfluenceForm = React.createClass
  handleChange: (e) ->
    score = e.target.value
    idea = this.props.idea
    id = this.props.id
    $.ajax
      url: "/api/projects/#{idea.project_id}/ideas/#{idea.id}/influences/#{id}"
      dataType: 'json'
      type: 'PUT'
      async: true
      data:
        authenticity_token: AUTH_TOKEN
        influence:
          score: score
      success: ((data) ->
        # this is a bad hack and should be fixed
        $('#clout').html(data.influence)
        $('#score').html(data.score)
      ).bind(this)
  render: ->
    min = 0
    max = 100
    cx = React.addons.classSet
    classes = cx(
      'range': true
      'range-primary': !this.props.negative
      'range-danger': this.props.negative
    )
    `<div>
      <div className={classes}>
        <input onChange={this.handleChange} name="score" max={max} min={min} value={this.props.score} type="range" />
        <output>{this.props.score}</output>
      </div>
      <small>{this.props.name}</small>
    </div>`
