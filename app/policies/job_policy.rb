class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    #vendor
    user_id == job.user_id
    # need one for user
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
    user.id == record.user_id && user.role == 'vendor'
  end

  def update?
    edit?
  end

  def destroy?
    user.id == record.user_id && user.role == 'vendor'
  end
end
