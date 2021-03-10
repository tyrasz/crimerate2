class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'user'
        scope.where(user: user)
      else
        scope.where(user: user)
      end

      # scope.where(user: @job.service.user)
      # scope.where(user: user)
      # scope.all
    end
  end

  def index?
    #vendor
    # if you can find any job by this user
    # if the first job is belong to this current_user
    # !record.empty? && record.first.user == user
    user.role == 'user'
  end

  def show?
    # record.user == user
    user.id == record.user_id
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
