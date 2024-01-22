class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :step1, :step2]
  before_action :authenticate_user!, only: [:destroy]

  def create
    # delaying log in
    sleep(2)
    requested_user = User.find_by(email: session[:user_email].downcase)

    next_password_letters = requested_user.next_password.split('-')

    password_params = {}
    next_password_letters.map.with_index do |letter, index|
      password_params["password_letter_#{letter}"] = params["password_letter_#{letter}"]
    end

    @user = User.authenticate_by(email: session[:user_email].downcase, **password_params)
    session[:user_email] = nil

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
        redirect_to after_login_path, notice: "Signed in."
        active_session = login @user
      end
    else
      if requested_user
        current_login_attempts = requested_user.login_attempts + 1
        increased_attempts = requested_user.update_columns(login_attempts: current_login_attempts)
      end
      flash.now[:alert] = "Incorrect email or password."
      render :step1, status: :unprocessable_entity
    end
  rescue
    flash.now[:alert] = "Incorrect email or password."
    render :step1, status: :unprocessable_entity
  end

  def destroy
    forget_active_session
    forget(current_user)
    logout
    redirect_to root_path, notice: "Signed out."
  end

  def step1
  end

  def step1_submit
    session[:user_email] = params[:email]
    redirect_to login_password_path
  end

  def step2
      user = User.find_by(email: session[:user_email].downcase)
      @password_permutation = random_combination = (1..16).to_a.shuffle.slice(1, 4).sort
      if user
        user.update_columns(next_password: @password_permutation.join('-'))
      end
  end
end
