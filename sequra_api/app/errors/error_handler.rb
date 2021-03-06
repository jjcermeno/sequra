# frozen_string_literal: true

module ErrorHandler
  def self.included(clazz)
    clazz.class_eval do
      rescue_from ErrorTypes::CustomError do |e|
        respond(e.status, e.message)
      end
    end
  end

  private

  def respond(status, message)
    case message
    when String then render json: "{\"response\":#{message}", status: status
    else render(json: { response: message }, status: status)
    end
  end
end
