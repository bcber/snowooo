class Todo
  DONE = 0
  TODO = 1
  include Mongoid::Document
  field :content, type: String
  field :status, type: Integer, default: TODO

  belongs_to :user

  def done
    self.update(status: Todo::DONE)
  end
end
