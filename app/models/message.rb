class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content

  belongs_to :reciever, class_name: "User", foreign_key: "reciever_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
end