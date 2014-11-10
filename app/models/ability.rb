class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :index, :show, :good,:hot, :no_comment, :to => :read

    if user
      user.roles.each{ |role| send(role, user) }
      can :manage, User, id: user.id
    else
      default
    end
  end

  def admin(user)
    can :manage, :all
  end

  def moderator(user)
    can :manage, Snowboard
    can :manage, Image
    can :manage, Todo
  end

  def editor(user)
    can :create, Post
    can :update, Post, user_id: user.id
  end

  def member(user)
    default
    can :create, Post
    can :create, Topic
    can :update, Topic, user_id: user.id
    can :edit, Post, user_id: user.id
    can :edit, User, id: user.id
  end

  def banned(user)

  end

  def default
    can :read, Snowboard
    can :read, Snowboot
    can :read, Snowbinding
    can :read, Video
    can :read, Place
    can :read, User
    can :show, User
    can :read, Post
    can :read, Topic
    can :node, Topic
  end
end
