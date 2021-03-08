class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def index?
    #vendor
    # if you can find any job by this user
    # if the first job is belong to this current_user
    !record.empty? && record.first.user == user
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
