# frozen_string_literal: true

module GM3156
  require 'hidapi'
  require_relative 'errors'

  class Device
    STATE_REQUEST = [0xb3, Random.rand(256), Random.rand(256), Random.rand(256), 0, 0, 0, 0].pack('C*')

    def initialize(vendor_id = 0x64bd, product_id = 0x74e3)
      self.vendor_id = vendor_id
      self.product_id = product_id
      self.speed = :slow
    end

    def open
      self.device = HIDAPI.open(vendor_id, product_id)
    end

    def close
      device.close
    end

    def read(&block)
      loop do
        Thread.new do
          begin
            block.call(read_current_state)
          rescue InvalidCaptureDataLengthError
            sleep 0.1
            retry
          end
        end
        sleep speed
      end
    end

    def speed=(speed)
      raise ArgumentError, 'Only :slow and :fast arguments allowed.' unless %i[slow fast].include?(speed)

      @speed = speed == :fast ? 0.5 : 1
    end

    private

    def read_current_state
      send_state_request
      data = read_cap_data
      raise InvalidCaptureDataLengthError.new('Capture data should have 8 bytes.', data) if data.length != 8
      
      data.unpack('H*').first
    end

    def send_state_request
      device.write(STATE_REQUEST)
    end

    def read_cap_data
      cap_data = nil

      cap_data = device.read_timeout(1000) until cap_data && !cap_data.empty?

      cap_data
    end

    attr_accessor :vendor_id, :product_id, :device
    attr_reader :speed
  end
end
