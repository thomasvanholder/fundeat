class CampaignPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def show?
    return true
  end

  def index?
    return true
  end

  def owners_dashboard?
    return true
  end

  def raising?
    return true
  end
end
