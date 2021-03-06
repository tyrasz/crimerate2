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
    user == record.user
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