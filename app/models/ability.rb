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
    can :manage, Snowboard
    can :manage, Image
    can :manage, Todo
  end

  def editor

  end

  def member
    default
  end

  def banned

  end

  def default
    can :read, Snowboard
    can :read, Snowboot
    can :read, Snowbinding
    can :read, Video
    can :read, Place
  end
end
