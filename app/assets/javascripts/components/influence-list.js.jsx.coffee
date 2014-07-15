###* @jsx React.DOM ###

@InfluenceList = React.createClass
  updateScore: (score) ->
    this.setState(score: score)
  getInitialState: ->
    influences: this.props.influences
    score: this.props.score
  render: ->
    if this.props.manager
      progressNodes = this.state.influences.map (inf) ->
        `<InfluenceForm key={inf.id} id={inf.id} score={inf.score} name={inf.factor.name} negative={inf.factor.is_negative}/>`
    else
      progressNodes = this.state.influences.map (inf) ->
        `<InfluenceBar key={inf.id} score={inf.score} name={inf.factor.name} negative={inf.factor.is_negative}/>`
    `<div className="text-center">
      <h5>Influence</h5>
      {progressNodes}
      <hr/>
      <h4>
        Influence: <span id="clout" className="clout">{this.state.score}</span>
      </h4>
    </div>`
