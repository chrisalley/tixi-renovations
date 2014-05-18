class UserPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user
        return scope if user.administrator?
      end
    end
  end

  def show?
    user ? user.administrator : false
  end
end
