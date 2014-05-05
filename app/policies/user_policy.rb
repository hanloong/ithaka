class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.owner?
    @user.admin?
  end

  def update?
    @user.owner?
    @user.admin?
  end

  def destroy?
    @user.owner?
    @user.admin?
  end
end
