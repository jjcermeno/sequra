class ApplicationController < ActionController::API
  include ErrorHandler

  private
  def respond_to_request(use_case, statuses=[:unprocessable_entity, :ok], look_for='error')
    data_result = use_case
    if look_for.to_s.downcase.include? 'error'
      status = data_result.errors.present? ? statuses.first : statuses.last
    else
      status = data_result.data.present? ? statuses.first : statuses.last
    end
    json = Oj.dump(data_result.as_json)
    {json: json, status: status}
  end
end
