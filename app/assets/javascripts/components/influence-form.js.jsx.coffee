###* @jsx React.DOM ###

token = $( 'meta[name="csrf-token"]').attr('content')

$.ajaxSetup
  beforeSend: ( xhr ) ->
    xhr.setRequestHeader( 'X-CSRF-Token' ,token )

@InfluenceForm = React.createClass
  handleMouseUp: (e) ->
    score = e.target.value
    this.props.handleChange(this.props.id, score, true)

  handleChange: (e) ->
    score = e.target.value
    this.props.handleChange(this.props.id, score, false)

  render: ->
    min = 0
    max = 100
    id = "range#{this.props.id}"

    cx = React.addons.classSet
    classes = cx
      'range': true
      'range-primary': !this.props.negative
      'range-danger': this.props.negative

    `<div>
      <div className={classes}>
        <input id={id} name="score" onKeyUp={this.handleMouseUp} onMouseUp={this.handleMouseUp} onChange={this.handleChange} max={max} min={min} value={this.props.score} type="range" />
        <output>{this.props.score}</output>
      </div>
      <small>{this.props.name}</small>
    </div>`
