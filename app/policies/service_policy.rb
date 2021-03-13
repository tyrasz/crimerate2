class ServicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    true
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
