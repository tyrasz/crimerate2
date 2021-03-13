class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'user'
        scope.where(user: user)
      else
        scope.where(service: user.services)
      end

      # scope.where(user: @job.service.user)
      # scope.where(user: user)
      # scope.all
    end
  end

  def show?
    # record.user == user OR vendor id is the user id of the service
    user.id == record.user_id || user.id == record.service.user_id
  end

  def new?
    user.role == 'user'
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
