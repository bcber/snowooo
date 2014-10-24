class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String
  field :up, type: Integer
  field :commentable_id, type:Integer
  field :commentable_type, type:String

  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
