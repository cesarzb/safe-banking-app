class SensitiveDataController < ApplicationController
  before_action :authenticate_user!

  def show
    @credit_card = current_user.credit_card
    @personal_id = current_user.personal_id
  end
end
