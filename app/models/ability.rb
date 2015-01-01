class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :index, :show, :good,:hot, :no_comment, :to => :read

    if user.present?
      if
        user.isAdmin
        can :manage, :all
      else
        member(user)
      end
    else
      default
    end
  end


  def member(user)
    can :create, Post
    can :create, Topic
    can :update, Topic, user_id: user.id
    can :edit, Post, user_id: user.id
    can :edit, User, id: user.id
    can :update, User, id:user.id
    can :new_message, User
    can :profile, User
    can :create, Post
    can :update, Post, user_id: user.id
    default
  end

  def default
    can :read , :Snowboard
    can :read, Snowboot
    can :read, Snowbinding
    can :read, Video
    can :read, Place
    can :read, User
    can :read, Post
    can :read, Topic
    can :node, Topic
    can :region, Place
    can :node, Video
    can :node, Post
  end
end
