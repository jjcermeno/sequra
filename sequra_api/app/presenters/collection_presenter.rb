# frozen_string_literal: true

class CollectionPresenter < BasePresenter
  def initialize(resource, presenter)
    super(resource)
    @presenter = presenter
  end

  def as_json
    @resource.map { |item| @presenter.new(item).as_json } if @resource.present?
  end
end
