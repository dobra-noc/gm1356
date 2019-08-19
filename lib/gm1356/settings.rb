# frozen_string_literal: true

module GM1356
  class Settings
    AVAILABLE_RANGES = [
      '30-120',
      '30-60',
      '50-100',
      '60-110',
      '80-130'
    ]

    def initialize(message)
      assign_settings(message)
    end

    def assign_settings(message)
      binary_settings = message[4].unpack('b4*').first.chars.map { |c| c.to_i == 1 }
      self.filter = binary_settings[0] ? :c : :a
      self.max_mode = binary_settings[1]
      self.speed = binary_settings[2] ? :fast : :slow
      self.range = message[5].to_i
    end

    def pack
      filter_bit = filter == :c ? 1 : 0
      max_mode_bit = max_mode ? 1 : 0
      speed_bit = speed == :fast ? 1 : 0

      boolean_options = "0#{speed_bit}#{max_mode_bit}#{filter_bit}".to_i(2)
      "#{boolean_options}#{range}".to_i(16)
    end

    attr_accessor :filter, :max_mode, :speed, :range

  end
end
