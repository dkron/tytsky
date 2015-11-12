module Telegram
  module Bot
    class Client
      TIMEOUT_EXCEPTIONS = [Timeout::Error]
      TIMEOUT_EXCEPTIONS << Net::ReadTimeout if Net.const_defined?(:ReadTimeout)

      attr_reader :api, :offset, :timeout, :logger

      def self.run(*args, &block)
        new(*args).run(&block)
      end

      def initialize(token, h = {})
        options = default_options.merge(h)
        @api = Api.new(token)
        @offset = options[:offset]
        @timeout = options[:timeout]
        @logger = options[:logger]
      end

      def run
        yield self
      end

      def listen(&block)
        logger.info('Starting bot')
        running = true
        Signal.trap('INT') { running = false }
        fetch_updates(&block) while running
        exit
      end

      def fetch_updates
        response = api.getUpdates(offset: offset, timeout: timeout)
        return unless response['ok']

        response['result'].each do |data|
          update = Types::Update.new(data)
          @offset = update.update_id.next
          log_incoming_message(update.message)
          yield update.message
        end
      rescue *TIMEOUT_EXCEPTIONS
        retry
      end

      private

      def default_options
        { offset: 0, timeout: 20, logger: NullLogger.new }
      end

      def log_incoming_message(message)
        logger.info(
          format(
            'Incoming message: text="%s" uid=%i',
            message.text,
            message.from.id
          )
        )
      end
    end
  end
end
