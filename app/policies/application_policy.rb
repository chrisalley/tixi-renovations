class ApplicationPolicy < Struct.new(:user, :record)
  def new?
    create?
  end

  def edit?
    update?
  end

  def create?
    user ? user.administrator : false
  end

  def update?
    user ? user.administrator : false
  end

  def destroy?
    user ? user.administrator : false
  end
end
