class RequestPolicy < ApplicationPolicy

  def index?
      true
  end

  def update?
      user.present?
  end
end