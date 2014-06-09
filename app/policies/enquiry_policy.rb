class EnquiryPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user
        return scope if user.administrator?
      end
    end
  end

  def show?
    if user
      return true if user.administrator?
    end
    false
  end

  def new?
    true
  end

  def create?
    true
  end
end
