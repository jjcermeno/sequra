require 'rails_helper'

RSpec.describe 'Disbursements API', type: :request do

  # Test suite for GET /categories
  describe 'GET /api/v1/disbursements' do
    # make HTTP get request before each example
    before { get '/api/v1/disbursements' }

    it 'returns disbursements' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(0)
      json['data'].each do |item|
        expect(item).to have_key("id")
        expect(item).to have_key("merchant_id")
        expect(item).to have_key("week")
        expect(item).to have_key("year")
        expect(item).to have_key("total_amount")
        expect(item).to have_key("total_fee")
        expect(item).to have_key("total_disbursement")
      end
    end

    xit 'returns info code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns info code 404' do
      expect(response).to have_http_status(404)
    end
  end

end