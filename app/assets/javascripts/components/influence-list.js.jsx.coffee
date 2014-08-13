###* @jsx React.DOM ###

@InfluenceList = React.createClass
  getInitialState: ->
    influences: this.props.influences
    score: this.props.idea.score
    influence: this.props.idea.influence
    votes: this.props.idea.votes_count

  loadInfluences: ->
    idea = this.props.idea
    $.ajax
      url: "/api/projects/#{idea.project_id}/ideas/#{idea.id}/influences"
      dataType: 'json'
      type: 'GET'
      success: ((data) ->
        this.setState
          score: data.score
          votes: data.votes 
          influence: data.influence
          influences: data.influences
      ).bind(this)

  updateScore: (id, score, save) ->
    ## Optimistic loading
    current_influences = this.state.influences
    influences = current_influences.map (inf) ->
      inf.score = score if inf.id == id
      inf

    this.setState
      influences: influences

    if save
      idea = this.props.idea
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
          this.setState
            score: data.score
            votes: data.votes 
            influence: data.influence
        ).bind(this)

        error: ( ->
          this.setState
            influences: current_influences
        ).bind(this)

  componentWillMount: ->
    this.loadInfluences
    setInterval(this.loadInfluences, 3000)

  render: ->
    # update some random elements
    $('#score').html(this.state.score.toFixed(1))
    if this.state.votes?
      $('#votes-count').html(this.state.votes)
    $('#votes').attr('data-original-title', this.state.votes)

    idea = this.props.idea
    if this.props.manager
      progressNodes = this.state.influences.map ((inf) ->
        `<InfluenceForm key={inf.id} handleChange={this.updateScore} id={inf.id} idea={idea} score={inf.score} name={inf.factor.name} negative={inf.factor.is_negative}/>`
      ).bind(this)
    else
      progressNodes = this.state.influences.map (inf) ->
        `<InfluenceBar key={inf.id} score={inf.score} name={inf.factor.name} negative={inf.factor.is_negative}/>`
    `<div className="text-center">
      <h5>Influence</h5>
      {progressNodes}
      <hr/>
      <h4>
        Influence: <span id="clout" className="clout">{this.state.influence * 100} %</span>
      </h4>
    </div>`
