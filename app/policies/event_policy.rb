class EventPolicy < ApplicationPolicy
  def update?
    user_is_owner?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      user.present? ? scope.where(user: user) : scope.all
    end
  end

  private

  def user_is_owner?
    user.present? && record.try(:user) == user
  end
end
