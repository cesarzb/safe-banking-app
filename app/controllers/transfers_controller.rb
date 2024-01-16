class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /transfers or /transfers.json
  def index
    # @transfers = Transfer.where(sender_id: current_user.id).or(Transfer.where(receiver_id: current_user.id))
    @transfers = Transfer.includes(:sender, :receiver).all
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
    @transfer.receiver_id = User.find_by(code: params[:transfer][:receiver_code])&.id
    @transfer.receiver_code = params[:transfer][:receiver_code]
    respond_to do |format|
      if @transfer.save
        format.html { redirect_to transfer_url(@transfer), notice: "Transfer was successfully created." }
        format.json { render :show, status: :created, location: @transfer,  notice: "Transfer wasn't successfully created." }
      else
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
      params.require(:transfer).permit(:title, :amount)
    end
end
