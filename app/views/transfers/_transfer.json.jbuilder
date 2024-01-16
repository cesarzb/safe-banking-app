json.extract! transfer, :id, :title, :amount, :sender_id, :receiver_id, :created_at, :updated_at
json.url transfer_url(transfer, format: :json)
