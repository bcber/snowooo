class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::Rateable
  ratyrate_rater

  validates_uniqueness_of :name, :email
  validates_presence_of :name, :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  # :confirmable
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

  field :isAdmin, type: Boolean, default:false

  # user system
  field :credit, type: Integer, default: 10
  #user exp
  field :exp,type: Integer, default: 10
  #user coin
  field :coin, type: Integer, default: 0
  #user prestige
  field :prestige, type: Integer, default: 0

  ## association
  # comments
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :posts, dependent: :destroy
  # onmiauthable
  has_many :omniauths
  has_many :send_messages, class_name: "Message", inverse_of: :sender
  has_many :receive_messages, class_name: "Message", inverse_of: :receiver
  has_many :reviews, dependent: :destroy

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
  
  def has_unread_messages?
    self.receive_messages.unread.any?
  end

  def unread_messages_count
    self.receive_messages.unread.count
  end

  def has_unread_notifications?
    self.notifications.unread.any?
  end

  def unread_notifications_count
    self.notifications.unread.count
  end

  def set_admin
    if not isAdmin
      update(isAdmin: true)
    end
  end

  def cancel_admin
    if isAdmin
      update(isAdmin: false)
    end
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
end
