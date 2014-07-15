###* @jsx React.DOM ###

@InfluenceList = React.createClass
  getInitialState: ->
    influences: this.props.influences
    score: this.props.score
  loadInfluences: ->
    idea = this.props.idea
    $.ajax
      url: "/api/projects/#{idea.project_id}/ideas/#{idea.id}/influences"
      dataType: 'json'
      type: 'GET'
      success: ((data) ->
        this.setState
          score: data.influence
          influences: data.influences
        $('#score').html(data.score)
      ).bind(this)
  componentWillMount: ->
    this.loadInfluences
    setInterval(this.loadInfluences, 3000)
  render: ->
    idea = this.props.idea
    if this.props.manager
      progressNodes = this.state.influences.map (inf) ->
        `<InfluenceForm key={inf.id} id={inf.id} idea={idea} score={inf.score} name={inf.factor.name} negative={inf.factor.is_negative}/>`
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
