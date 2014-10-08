class Todo
  DONE = 0
  TODO = 1
  include Mongoid::Document
  field :content, type: String
  field :status, type: Integer, default: TODO
  field :created_at, type: Time, default: -> {Time.now}
  field :done_at, type: Time

  belongs_to :user, dependent: :destroy

  def done
    self.update(status: Todo::DONE)
    self.update(done_at: Time.now)
  end
end
