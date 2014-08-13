class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show
    @user.admin? || @user == current_user || @user.organisation == current_user.organisation
  end

  def index?
    @user.admin? || @user.owner?
  end

  def update?
    @user.admin? || @user.owner? && @record.organisation_id == @user.organisation_id
  end

  def destroy?
    @user.admin? || @user.owner? && @record.organisation_id == @user.organisation_id
  end
end
