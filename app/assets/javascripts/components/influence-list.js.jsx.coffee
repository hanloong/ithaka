###* @jsx React.DOM ###

@InfluenceList = React.createClass
  getInitialState: ->
    influences: this.props.influences
    score: this.props.score
  render: ->
    progressNodes = this.state.influences.map (inf) ->
      `<InfluenceBar key={inf.id} score={inf.score} name={inf.factor.name} negative={inf.factor.is_negative}/>`
    `<div className="text-center">
      <h5>Influence</h5>
      {progressNodes}
      <hr/>
      <h4>
        Influence: <span className="clout">{this.state.score}</span>
      </h4>
    </div>`
