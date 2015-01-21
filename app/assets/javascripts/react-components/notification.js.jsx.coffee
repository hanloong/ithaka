###* @jsx React.DOM ###

@NotificationsList = React.createClass
  getInitialState: ->
    notifications: []

  componentWillMount: ->
    this.loadNotifications()
    this.props.interval = setInterval(this.loadNotifications, 3000)

  componentWillUnmount: ->
    clearInterval(this.props.interval)

  loadNotifications: ->
    $.ajax
      url: '/api/events'
      dataType: 'json'
      type: 'GET'
      success: (data) =>
        this.setState
          notifications: data

  render: ->
    notifications = Array()

    cx = React.addons.classSet
    classes = cx
      'dropdown-menu': true
      'hide': this.state.notifications == 0

    `<span>
    </span>`

@NotificationItem = React.createClass
  render: ->
    created = new Date(this.props.event.created_at)
    `<li>
      <a href={this.props.event.url}>
        {this.props.event.message}
        <br/>
        <small>{created.toLocaleString()}</small>
      </a>
    </li>`
