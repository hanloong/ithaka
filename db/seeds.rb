culture = Area.find_or_create_by(name: 'Culture')
income = Area.find_or_create_by(name: 'Income')
budget = Area.find_or_create_by(name: 'Budget')
productivity = Area.find_or_create_by(name: 'Productivity')

org = Organisation.find_or_create_by(name: 'Votation.io')
u = User.find_or_create_by(email: 'hanloongliauw@gmail.com')
if u.id.nil?
  u.name = 'Han'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.role = :admin
  u.organisation_id = org.id
  u.save
end

admin = User.find_or_create_by(email: 'admin@votation.io')
if admin.id.nil?
  admin.name = 'Admin'
  admin.password = 'password'
  admin.password_confirmation = 'password'
  admin.role = :admin
  admin.organisation_id = org.id
  admin.save
end

project = Project.find_or_create_by(name: "Votation.io", description: "Dog fooding", public: true, organisation: org, user: admin)
project = Project.find_or_create_by(name: "Sandbox", description: "Dog fooding", public: true, organisation: org, user: admin)
project = Project.find_or_create_by(name: "Votation Private", description: "Dog fooding", public: false, organisation: org, user: admin)

Factor.find_or_create_by(name: 'Revenue', weight: 100, area: income, project: project)
Factor.find_or_create_by(name: 'Risk', weight: 100, area: income, project: project, is_negative: true)
Factor.find_or_create_by(name: 'Difficulty', weight: 100, area: budget, project: project, is_negative: true)
Factor.find_or_create_by(name: 'Workplace Moral', weight: 100, area: culture, project: project)
Factor.find_or_create_by(name: 'Productivity', weight: 100, area: productivity, project: project)
