culture = Area.find_or_create_by(name: 'Culture')
income = Area.find_or_create_by(name: 'Income')
budget = Area.find_or_create_by(name: 'Budget')
productivity = Area.find_or_create_by(name: 'Productivity')

u = User.find_or_create_by(email: 'hanloongliauw@gmail.com')
if u.id.nil?
  u.password = 'password'
  u.password_confirmation = 'password'
  u.role = :admin
  u.save
end

project = Project.find_or_create_by(name: "Votation", description: "Dog fooding")

Factor.find_or_create_by(name: 'Income', weight: 20, area: income, project: project)
Factor.find_or_create_by(name: 'Difficulty', weight: 10, area: budget, project: project)

['Staff Communication', 'Team Building', 'General Moral', 'Extra Curicular Activities'].each do |f|
  Factor.find_or_create_by(name: f, weight: 10, area: culture, project: project)
end

%w(Efficency Quality Safety).each do |f|
  Factor.find_or_create_by(name: f, weight: 10, area: productivity, project: project)
end
