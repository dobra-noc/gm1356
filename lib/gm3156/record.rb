# frozen_string_literal: true

module GM3156
  class Record
    def initialize(message)
      self.timestamp = Time.now
      self.spl = extract_spl(message)
      settings = extract_settings(message)
      self.filter = settings[:filter]
      self.max_mode = settings[:max_mode]
      self.speed = settings[:speed]
    end

    def extract_spl(message)
      message[0..3].to_i(16).to_s.insert(-2, '.').to_f
    end

    def extract_settings(message)
      binary_settings = message[4].unpack('b4*').first.chars.map { |c| c.to_i == 1 }
      {
        filter: binary_settings[0] ? :c : :a,
        max_mode: binary_settings[1],
        speed: binary_settings[2] ? :fast : :slow
      }
    end

    def print
      output = "#{timestamp.strftime('%H:%M:%S')} \t SPL: #{spl}dB#{filter.to_s.capitalize}"
      output += "\t MAX mode" if max_mode
      puts output
    end

    attr_reader :timestamp, :spl, :filter, :max_mode, :speed, :range

    private

    attr_writer :timestamp, :spl, :filter, :max_mode, :speed, :range
  end
end
