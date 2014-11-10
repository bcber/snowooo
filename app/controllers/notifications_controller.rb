class NotificationsController < ApplicationController
  before_filter :require_user
  before_action :find_notification, only: [:read,:unread]
  def show
    @unread = current_user.notifications.unread.desc(:created_at)
    @readed = current_user.notifications.readed.desc(:created_at).limit(10)
  end

  def history
    @notifications = current_user.notifications.readed.desc(:created_at).paginate(page: params[:page], per_page: 10)
  end

  def read
    @notification.mark_as_read
    redirect_to notification_path
  end

  def unread
    @notification.mark_as_unread
    redirect_to notification_path
  end

  private
  def find_notification
    @notification = Notification.find(params[:id])
  end
end