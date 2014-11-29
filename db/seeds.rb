org = Organisation.find_or_create_by(name: 'Sixty Three')
u = User.find_or_create_by(email: 'hanloongliauw@gmail.com')
if u.id.nil?
  u.name = 'Han'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.role = :admin
  u.organisation_id = org.id
  u.save
end

admin = User.find_or_create_by(email: 'admin@ithaka.io')
if admin.id.nil?
  admin.name = 'Admin'
  admin.password = 'password'
  admin.password_confirmation = 'password'
  admin.role = :admin
  admin.organisation_id = org.id
  admin.save
end

Project.find_or_create_by(name: "Ithaka", description: "Dog fooding", public: true, organisation: org, user: admin)
Project.find_or_create_by(name: "Sandbox", description: "Dog fooding", public: true, organisation: org, user: admin)
Project.find_or_create_by(name: "Ithaka Private", description: "Dog fooding", public: false, organisation: org, user: admin)

Project.all.each do |project|
  Factor.find_or_create_by(name: 'Revenue', weight: 100, project: project)
  Factor.find_or_create_by(name: 'Risk', weight: 100, project: project, is_negative: true)
  Factor.find_or_create_by(name: 'Difficulty', weight: 100, project: project, is_negative: true)
  Factor.find_or_create_by(name: 'Workplace Morale', weight: 100, project: project)
  Factor.find_or_create_by(name: 'Productivity', weight: 100, project: project)
end
