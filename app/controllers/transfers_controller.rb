class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :user_transfer, only: :show

  # GET /transfers or /transfers.json
  def index
    @transfers = Transfer.where(sender_id: current_user.id).or(Transfer.where(receiver_id: current_user.id)).order(created_at: :desc)
  end

  # GET /transfers/1 or /transfers/1.json
  def show
  end

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # POST /transfers or /transfers.json
  def create
    @transfer = Transfer.new(transfer_params)
    @transfer.sender_id = current_user.id
    @transfer.sender_code = current_user.code
    receiver = User.find_by(code: params[:transfer][:receiver_code])
    @transfer.receiver_id = receiver&.id
    @transfer.receiver_code = params[:transfer][:receiver_code]

    sender_balance = current_user.balance
    receiver_balance = receiver&.balance

    if !receiver
      flash[:alert] = "There is no such receiver"
      return redirect_to new_transfer_path
    end

    if receiver == current_user
      flash[:alert] = "You can't transfers funds to yourself"
      return redirect_to new_transfer_path
    end

    current_user.update_columns(balance: (sender_balance - @transfer.amount))

    receiver.update_columns(balance: (receiver_balance + @transfer.amount)) if receiver

    begin
      @transfer.save!
      flash[:notice] = "Transfer was successfully created."
      respond_to do |format|
        format.html { redirect_to transfer_url(@transfer), status: :created }
        format.json { render :show, status: :created, location: @transfer }
      end
      return
    rescue
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transfer_params
      params.require(:transfer).permit(:title, :amount, :receiver_name)
    end

    def user_transfer
      transfer = Transfer.find_by(id: params[:id])
       if ((transfer.sender_id != current_user.id)&&(transfer.receiver_id != current_user.id))
         redirect_to root_path
       end
    end
end
