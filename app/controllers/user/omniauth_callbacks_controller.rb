class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def weibo
    omniauth = request.env['omniauth.auth']

    omniauth = Omniauth.find_or_initialize_by(provider: omniauth.provider, uid:omniauth.uid)

    if omniauth.new_record?
      if user_signed_in?
        omniauth.user = current_user
        omniauth.save
        flash[:notice] = "绑定微博成功，现在你可以用微博登录本网站"
        redirect_to root_path
      else
        flash[:notice] = "请先注册本站的一个帐号,然后再绑定你的微博"
        redirect_to signup_path
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
