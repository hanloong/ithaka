###* @jsx React.DOM ###

InfluenceBar = React.createClass
  render: ->
    barStyle =
      width: this.props.score + 'px'
    min = 0
    max = 100
    `<div>
      <div className="progress">
        <div className="progress-bar" role="progressbar" aria-valuenow={this.props.score} style={barStyle} aria-valuemin={min} aria-valuemax={max}>
        </div>
      </div>
      <small>{this.props.name}</small>
    </div>`

React.renderComponent(
  `<InfluenceBar score="14" name="test"/>`,
  document.getElementById('influence-container')
)
