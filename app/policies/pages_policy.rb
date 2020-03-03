class PagesPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def home
      true
    end
  end
end
