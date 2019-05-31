# frozen_string_literal: true

module GM3156
  class InvalidCaptureDataLengthError < StandardError
    attr_reader :data

    def initialize(msg, data)
      @data = data
      super(msg)
    end
  end
end
