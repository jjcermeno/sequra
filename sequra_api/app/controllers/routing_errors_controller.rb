# frozen_string_literal: true

class RoutingErrorsController < ApplicationController
  def show_404
    raise ErrorTypes::ResourceNotFound
  end
end
