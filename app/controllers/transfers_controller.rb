class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

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
    @transfer.receiver_id = User.find_by(code: params[:transfer][:receiver_code])&.id
    @transfer.receiver_code = params[:transfer][:receiver_code]

    if @transfer.amount <= 0
      flash[:alert] = "Invalid transfer amount. Amount must be greater than 0."
      return redirect_to new_transfer_path
    end

    if current_user.balance < @transfer.amount
      flash[:alert] = "Insufficient funds. Transfer amount exceeds sender's balance."
      return redirect_to new_transfer_path
    end

    ActiveRecord::Base.transaction do
      begin
        current_user.decrement!(:balance, @transfer.amount)

        receiver = User.find_by(code: params[:transfer][:receiver_code])
        receiver.increment!(:balance, @transfer.amount) if receiver

        @transfer.save!
        puts "\n\n\n\n\n\n\nTransfer errors!"
        puts "#{@transfer.errors.full_messages}"
        puts "Transfer created!"
        puts "Transfers number: #{Transfer.all.size}\n\n\n\n\n"
        flash[:notice] = "Transfer was successfully created."
        respond_to do |format|
          format.html { redirect_to transfer_url(@transfer), status: :created }
          format.json { render :show, status: :created, location: @transfer }
        end
        return
      rescue ActiveRecord::RecordInvalid
        raise ActiveRecord::Rollback
      end
    end

    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @transfer.errors, status: :unprocessable_entity }
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
