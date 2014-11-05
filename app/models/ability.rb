class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.roles.each{ |role| send(role, user) }
      can :manage, User, id: user.id
    else
      default
    end
  end

  def admin(uid)
    can :manage, :all
  end

  def moderator(uid)
    can :manage, Snowboard
    can :manage, Image
    can :manage, Todo
  end

  def editor(uid)
    can :create, Post
    can :update, Post, user_id: uid
  end

  def member(uid)
    default
  end

  def banned(uid)

  end

  def default
    can :read, Snowboard
    can :read, Snowboot
    can :read, Snowbinding
    can :read, Video
    can :read, Place
    can :read, User
    can :read, Post
    can :create, Post
    can :edit, Post
  end
end
