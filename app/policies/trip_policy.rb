class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def step_one?
    true
  end

  def step_two?
    true
  end

  def step_three?
    true
  end

  def flight_choice?
    true
  end

  def activity_choice?
    true
  end

  def hotel_choice?
    true
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
