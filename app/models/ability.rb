class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.roles.each{ |role| send(role) }
    else
      default
    end
  end

  def admin
    can :manage, :all
  end

  def moderator

  end

  def editor

  end

  def member

  end

  def banned

  end

  def default
    can :read, Snowboard
  end
end
