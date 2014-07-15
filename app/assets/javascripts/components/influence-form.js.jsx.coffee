###* @jsx React.DOM ###

token = $( 'meta[name="csrf-token"]').attr('content')

$.ajaxSetup
  beforeSend: ( xhr ) ->
    xhr.setRequestHeader( 'X-CSRF-Token' ,token )

@InfluenceForm = React.createClass
  mixins: [React.addons.LinkedStateMixin]
  handleChange: (e) ->
    score = e.target.value
    this.props.handleChange(this.props.id, score)
  render: ->
    min = 0
    max = 100
    cx = React.addons.classSet
    id = "range#{this.props.id}"
    classes = cx(
      'range': true
      'range-primary': !this.props.negative
      'range-danger': this.props.negative
    )
    `<div>
      <div className={classes}>
        <input id={id} name="score" onChange={this.handleChange} max={max} min={min} value={this.props.score} type="range" />
        <output>{this.props.score}</output>
      </div>
      <small>{this.props.name}</small>
    </div>`
