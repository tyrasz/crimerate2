class ServicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'user'
        scope.where(user: user)
      else
      end
    end
  end

  def index?
    user.role == 'user'
  end

  def show?
    user.role == 'user' || user == record.user
  end

  def new?
    user.role == 'vendor'
  end

  def create?
    new?
  end

  def edit?
    # user ==> current_user
    user == record.user
  end

  def update?
    edit?
  end

  def destroy?
    user == record.user
  end

end
