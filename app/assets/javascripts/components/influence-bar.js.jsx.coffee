###* @jsx React.DOM ###

@InfluenceBar = React.createClass
  render: ->
    barStyle = 
      width: this.props.score + 'px'
    min = 0
    max = 100
    cx = React.addons.classSet
    classes = cx(
      'progress-bar': true
      'progress-bar-info': !this.props.negative
      'progress-bar-danger': this.props.negative
    )
    `<div>
      <div className="progress">
        <div className={classes} role="progressbar" aria-valuenow={this.props.score} style={barStyle} aria-valuemin={min} aria-valuemax={max}>
        </div>
      </div>
      <small>{this.props.name}</small>
    </div>`
