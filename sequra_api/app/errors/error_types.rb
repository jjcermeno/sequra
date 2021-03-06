# frozen_string_literal: true

module ErrorTypes
  class CustomError < StandardError
    attr_reader :status, :message

    def initialize(_status = nil, _message = nil)
      super()
      @status = _status || :internal_server_error
      @message = _message || {"message":"Internal server error"}
    end
  end

  class BadRequest < CustomError
    def initialize(errors)
      super(:bad_request, handle_schema_errors(errors))
    end

    private

    def handle_schema_errors(errors)
      {
      errors: errors.map do |error|
        {
        field: error.path.join('.'),
        message: localized_message(error.text)
        }
      end
      }
    end

    def localized_message(error_text)
      array = error_text.split('|')
      {
      key: array.shift,
      args: array.map(&Oj.method(:load))
      }
    end
  end

  class NotAuthorized < CustomError
    def initialize
      super(:unauthorized, {"message":"Not authorized"})
    end
  end

  class ResourceNotFound < CustomError
    def initialize
      super(:not_found, {"message":"Resource not found"})
    end
  end
end
