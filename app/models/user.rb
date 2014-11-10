class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Letsrate

  letsrate_rater

  validates_uniqueness_of :name, :email
  validates_presence_of :name, :email
  ROLES = %w[admin moderator editor member banned]
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: [:weibo]

  ## Database authenticatable
  field :email,              type: String
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  #签到
  field :check_in_at, type: Time
  field :check_in_count, type: Integer, default: 0

  field :name, type: String
  field :avatar
  mount_uploader :avatar, AvatarUploader

  field :description, default:'这位用户还没有写自我介绍'
  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :roles_mask, type: Integer, default: 2**ROLES.index('member')

  # user system
  field :credit, type: Integer, default: 10
  #user exp
  field :exp,type: Integer, default: 10
  #user coin
  field :coin, type: Integer, default: 0
  #user prestige
  field :prestige, type: Integer, default: 0

  # comments
  has_many :todos, dependent: :destroy
  has_many :comments

  has_many :notifications

  has_many :posts
  # onmiauthable
  has_many :omniauths

  after_create :setAdmin

  # use level
  def level
    case self.exp
      when 0..99 then 0
      when 100.239 then 1
      when 240..419 then 2
      when 420..639 then 3
      when 640..899 then 4
      when 900..1199 then 5
      when 1200..1539 then 6
      when 1540..1919 then 7
      when 1920..2339 then 8
      when 2340..2799 then 9
      when 2800..3299 then 10
      when 3300..3839 then 11
      when 3840..4419 then 12
      else 0
    end
  end
  
  def setAdmin
    if ENV['admin_emails'].include?(email) and not has_role?(:admin)
      logger.info "*"*40+"add #{email} to admin role!"
      self.update(roles_mask: 1)
      self.confirm!
    end
  end

  def has_unread_notifications?
    self.notifications.unread.any?
  end

  def unread_notifications_count
    self.notifications.unread.count
  end

  def check_in
    self.touch(:check_in_at)
    self.add_credit 10
    self.add_exp 10
    self.inc(check_in_count: 1)
  end

  def check_in?
    !!self.check_in_at && self.check_in_at.today?
  end

  %W{credit exp coin prestige}.each do |action|
    define_method("add_#{action}") do |number|
      self.inc("#{action}" => "#{number}".to_i)
    end

    define_method("dec_#{action}") do |number|
      self.inc("#{action}" => "#{number}".to_i * -1 )
    end
  end

  # 赞
  def like(likeable)
    return false if likeable.blank?
    return false if likeable.liked_by_user?(self)
    likeable.push(liked_user_ids: self.id)
    likeable.inc(likes_count: 1)
    likeable.touch
  end

  #取消赞
  def unlike(likeable)
    return false if likeable.blank?
    return false if not likeable.liked_by_user?(self)
    likeable.pull(liked_user_ids: self.id)
    likeable.inc(likes_count: -1)
    likeable.touch
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    !!roles.index(role.to_s)
  end

  # many member rule
  def member_rule_post
    self.add_credit(10)
    self.add_exp(10)
    self.add_coin(5)
    self.add_prestige(5)
  end

  def member_rule_top_post
    self.add_credit 30
    self.add_exp 30
    self.add_coin 30
    self.add_prestige 30
  end

  class << self
    def serialize_from_session(key, salt)
      record = to_adapter.get(key[0]["$oid"])
      record if record && record.authenticatable_salt == salt
    end
  end

  protected 

  # TODO use mail
  def send_devise_notification(notification, token,*args)
    MailWorker.perform_async(email, token);
  end


  private

  # def send_pending_notifications
  # end

  # def peding_notifications
  #   @send_pending_notifications ||= []
  # end
end
