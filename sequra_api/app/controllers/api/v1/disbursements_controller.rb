module Api
  module V1
    class DisbursementsController < ApplicationController

      # GET /api/v1/disbursements
      def index
        response = respond_to_request(Manager.get_disbursements(params), [:ok, :not_found], 'data')
        render json: response[:json], status: response[:status]
      end

    end
  end
end
