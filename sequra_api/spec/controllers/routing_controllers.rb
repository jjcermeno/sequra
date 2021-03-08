# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoutingErrorsController, type: :controller do
  describe '#show_404' do
    it 'should render a 404 message' do
      get :show_404, format: :json
      expect(response.status).to eq 404
      expect(response.body).to eq '{"response":{"message":"Resource not found"}}'
    end
  end
end
