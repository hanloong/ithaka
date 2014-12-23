Ithaka.User = DS.Model.extend
  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'
  name: DS.attr 'string'
  email: DS.attr 'string'
  organisation_name: DS.attr 'string'
  avatar_url: DS.attr 'url'
