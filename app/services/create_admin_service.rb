class CreateAdminService
  def call
    admin_email = Rails.application.secrets.admin_email
    admin_password = Rails.application.secrets.admin_password
    User.find_or_create_by!(email: admin_email) do |user|
      user.password = admin_password
      user.password_confirmation = admin_password
      user.admin!
    end
  end
end
