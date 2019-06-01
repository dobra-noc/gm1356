# frozen_string_literal: true

require 'pry'

module GM3156
  require 'hidapi'
  require_relative 'errors'
  require_relative 'settings'
  require_relative 'record'

  class Device
    STATE_REQUEST = [0xb3, Random.rand(256), Random.rand(256), Random.rand(256), 0, 0, 0, 0].pack('C*')

    def initialize(vendor_id = 0x64bd, product_id = 0x74e3, **args)
      self.vendor_id = vendor_id
      self.product_id = product_id
      self.device = HIDAPI.open(vendor_id, product_id)
      read_current_state
      set_settings(**args) unless args.empty?
    end

    def close
      device.close
    end

    def read(&block)
      loop do
        Thread.new do
          read_current_state(&block)
        end
        sleep settings.speed == :fast? ? 0.5 : 1
      end
    end

    def set_settings(**args)
      args.each do |name, value|
        settings.send("#{name}=", value) if settings.respond_to?("#{name}=")
      end
      data = [0x56, settings.pack, 0, 0, 0, 0, 0, 0].pack('C*')

      device.write(data)
      read_cap_data
      sleep(0.1)
    end

    private

    def read_current_state(&block)
      begin
        send_state_request
        data = read_cap_data

        raise InvalidCaptureDataLengthError.new('Capture data should have 8 bytes.', data) if data.length != 8

        record = Record.new(data.unpack('H*').first)
        self.settings = record.settings
        block_given? ? block.call(record) : record
      rescue InvalidCaptureDataLengthError
        sleep 0.1
        retry
      end
    end

    def send_state_request
      device.write(STATE_REQUEST)
    end

    def read_cap_data
      cap_data = nil
      cap_data = device.read_timeout(1000) until cap_data && !cap_data.empty?
      cap_data
    end

    attr_accessor :vendor_id, :product_id, :device, :settings
  end
end
