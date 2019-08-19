# frozen_string_literal: true

module GM1356
  require_relative 'settings'

  class Record
    def initialize(message)
      self.timestamp = Time.now
      self.spl = assign_spl(message)
      self.settings = Settings.new(message)
    end

    def assign_spl(message)
      message[0..3].to_i(16).to_s.insert(-2, '.').to_f
    end

    def filter
      settings.filter.to_s.capitalize
    end

    def format
      "dB#{filter}"
    end

    def to_s
      output = "#{timestamp.strftime('%H:%M:%S')} \t SPL: #{spl}#{format}"
      output += "\t MAX mode" if settings.max_mode
      output
    end

    attr_reader :timestamp, :spl, :settings

    private

    attr_writer :timestamp, :spl, :settings
  end
end
