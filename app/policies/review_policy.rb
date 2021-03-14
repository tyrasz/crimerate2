class ReviewPolicy < ApplicationPolicy
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
    true
    # (user == record.user && user.role == 'user') || (user == record.user && user.role == 'vendor')
  end

  def create?
    new?
  end

  def edit?
    # user ==> current_user
    # record ==> service
    # if user == service.user
    (user.id == record.user_id && user.role == 'user') || (user_id == job.user_id && user.role == 'vendor')
  end

  def update?
    edit?
  end

  def destroy?
    user_id == job.user_id && user.role == 'vendor'
    # user.id == record.user_id && user.role == 'user'

  end
end
