class StaticPagesController < ApplicationController
  def home
    redirect_to transfers_path if current_user
  end
end
