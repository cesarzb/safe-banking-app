class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]
  before_action :authenticate_user!, only: [:destroy]

  def create
    requested_user = User.find_by(email: params[:user][:email])
    @user = User.authenticate_by(email: params[:user][:email].downcase, password: params[:user][:password])
    if @user
      if(@user.login_attempts > 7)
        flash[:notice] = "Listen mate, you forgor your pass like 7 times, write your email so we can reconfirm you :/"
        @user.update_columns(confirmed_at: nil, unconfirmed_email: @user.email)
      end
      if @user.unconfirmed?
        redirect_to new_confirmation_path, alert: "Email unconfirmed"
      else
        @user.update_columns(login_attempts: 0)
        after_login_path = session[:user_return_to] || root_path
        login @user
        remember(@user) if params[:user][:remember_me] == "1"
        redirect_to after_login_path, notice: "Signed in."
        active_session = login @user
        remember(active_session) if params[:user][:remember_me] == "1"
      end
    else
      if requested_user
        current_login_attempts = requested_user.login_attempts + 1
        increased_attempts = requested_user.update_columns(login_attempts: current_login_attempts)
      end
      flash.now[:alert] = "Incorrect email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    forget_active_session
    forget(current_user)
    logout
    redirect_to root_path, notice: "Signed out."
  end

  def new
  end

end
