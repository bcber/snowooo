class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def weibo
    omniauth = request.env['omniauth.auth']
    logger.info "omniauth"+"*"*50

    omniauth = Omniauth.find_or_initialize_by(provider: omniauth.provider, uid:omniauth.uid)
    
    logger.info "+"*80
    logger.info omniauth.new_record?

    if omniauth.new_record?
      if user_signed_in?
        omniauth.user = current_user
        omniauth.save
        flash[:notice] = "bind weibo success, you can use weibo login in our site"
        redirect_to root_path
      else
        flash[:notice] = "register first"
        redirect_to root_path
      end
    else
      sign_in_and_redirect omniauth.user
    end

  end
  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  protected
  def after_omniauth_failure_path_for(scope)
    super(scope)
  end
end
