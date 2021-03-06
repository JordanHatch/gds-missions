class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def new
    # new.html.erb
  end

  def create
    unless auth_hash.present?
      fail_and_redirect
      return
    end

    @user = User.find_or_create_from_auth_hash!(auth_hash)
    if @user.present?
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.name}"
      redirect_to root_path
    else
      fail_and_redirect
    end
  rescue User::CreationFailure => e
    fail_and_redirect("Could not sign you in for the first time: #{e.message}")
  end

  def sign_out
    session[:user_id] = nil
    flash[:notice] = "You've been signed out"
    redirect_to root_path
  end

  def failure
    flash[:alert] = "Please sign in"
    redirect_to new_session_path
  end

private
  def fail_and_redirect(message="There was a problem signing you in")
    flash[:alert] = message
    redirect_to new_session_path
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
