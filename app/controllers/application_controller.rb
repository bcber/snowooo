class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def require_user
    if current_user.blank?
      respond_to do |format|
        format.html { redirect_to login_path }
        format.all { head(:unauthorized) }
      end
    end
  end

  def info
    request.env['devise.mapping'] if Rails.env.development?
  end


  def set_seo_meta(title = '', meta_description = '', meta_keywords='')
    @page_title = "#{title}" if title.length > 0
    @meta_keywords = meta_keywords
    @meta_description = meta_description
    @meta_keywords = ENV['keywords'] if meta_keywords.length == 0
    @meta_description = ENV['keywords'] if meta_description.length == 0
  end


  def date(time)
    time.strftime('%m-%d-%Y')
  end

  def year
    Time.now.year
  end

  def render_404
    render_optional_error_file(404)
  end

  def render_optional_error_file(status_code)
    status = status_code.to_s
    fname = %W(404 403 422 500).include?(status) ? status : 'unknown'
    render template: "/errors/#{fname}", format: [:html],
           handler: [:erb], status: status, layout: 'application'
  end

  helper_method :info, :admin?, :year, :date
end
