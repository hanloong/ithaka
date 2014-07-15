###* @jsx React.DOM ###

token = $( 'meta[name="csrf-token"]').attr('content')

$.ajaxSetup
  beforeSend: ( xhr ) ->
    xhr.setRequestHeader( 'X-CSRF-Token' ,token )

@InfluenceForm = React.createClass
  getInitialState: ->
    score: this.props.score
  handleChange: (e) ->
    score = e.target.value
    this.setState(score: score)
    $.ajax
      url: '/api/influences/' + this.props.id
      dataType: 'json'
      type: 'PUT'
      data:
        authenticity_token: AUTH_TOKEN
        influence:
          score: score
      success: ((data) ->
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
        <input onChange={this.handleChange} name="score" max={max} min={min} value={this.state.score} type="range" />
        <output>{this.state.score}</output>
      </div>
      <small>{this.props.name}</small>
    </div>`
