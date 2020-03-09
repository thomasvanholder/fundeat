class InvestmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def dashboard?
    return true
  end

  def myinvestments?
    return true
  end

  def rewards?
    return true
  end

  def map?
    return true
  end
  def new?
    return true
  end

  def create?
    return true
  end

  def index?
    return true
  end
  def show?
    return true
  end
  def confirmation?
    return true
  end
end
