class MessagesController < ApplicationController
  def new
    @message = Message.new
    @message.receiver= User.find(params[:receiver])
  end

  def create
    message = Message.new(message_params)
    message.sender = current_user
    if message.save
      render 'success'
    end
  end

  def index
    @messages = current_user.receive_messages.desc(:created_at)
  end

  def readed
    message = Message.find(params[:message])
    message.update(readed:true)
    render text: 'ok'
  end

  def show

  end

  private
  def message_params
    params[:message].permit(:receiver_id,:content)
  end
end