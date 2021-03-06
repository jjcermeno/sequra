# frozen_string_literal: true

class BasePresenter

  attr_reader :resource, :parameters
  
  def initialize(resource, params = nil)
    @resource = resource
    @parameters = params
  end
end
