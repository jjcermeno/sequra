class DataResult

  attr_accessor :data, :meta, :errors

  def initialize(args)
    @data = args[:data]
    @meta = args[:meta]
    @errors = args[:errors]
  end

end