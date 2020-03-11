class UserPolicy < ApplicationPolicy
  def logged_in?
    user.present?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
