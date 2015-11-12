module Telegram
  module Bot
    module Types
      class User < Base
        attribute :id, Integer
        attribute :first_name, String
        attribute :last_name, String
        attribute :username, String
      end
    end
  end
end
