class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content
  field :readed, type: Boolean, default: false

  scope :unread, -> { where(readed: false) }
  scope :readed, -> {where(readed: true)}

  belongs_to :sender, class_name: "User",inverse_of: :send_messages
  belongs_to :receiver, class_name:"User", inverse_of: :receive_messages
end