class ServicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
    # record ==> service
    # if user == service.user
    user == record.user && user.role == 'vendor'
  end

  def update?
    edit?
  end

  def destroy?
    user == record.user && user.role == 'vendor'
  end
end
