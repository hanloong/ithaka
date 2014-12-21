Ithaka.Project = DS.Model.extend

  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'
  name: DS.attr 'string'
  description: DS.attr 'string'
  public: DS.attr 'boolean'
  sandbox: DS.attr 'boolean'
  allow_anonymous: DS.attr 'boolean'
  expires_at: DS.attr 'date'
