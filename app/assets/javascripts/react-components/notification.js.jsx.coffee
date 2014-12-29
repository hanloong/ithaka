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
    notifications = this.state.notifications.map (event) =>
      `<NotificationItem key={event.id} event={event}/>`

    cx = React.addons.classSet
    classes = cx
      'dropdown-menu': true
      'hide': this.state.notifications == 0

    `<li className='dropdown large-icon hidden-xs hidden-sm' rel='tooltip' data-toggle='tooltip' data-placement='bottom' title='Notifications'>
      <a href='#'className="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
        <i className="fa fa-bell"></i>
        <span className="caret"></span>
      </a>
      <ul className={classes} role='menu'>
        {notifications}
      </ul>
    </li>`

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
