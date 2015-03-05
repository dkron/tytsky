# coding: utf-8
require 'base64'

module TytskyModules
  module Talk
    def self.included(base)
      base.register_method(:talk, 'Сказать что-нибудь')
      base.register_method(:monolog, 'Продолжительный словесный поток')
    end

    def talk
      random_word
    end

    def monolog
      rand(35).times do
        puts '- %s' % random_word
        sleep(3)
      end
      talk
    end

    private

    def random_word
      Base64.decode64(words_dictionary.sample).force_encoding('UTF-8')
    end

    def words_dictionary
      @words_dictionary ||= File.readlines(dictionary_path)
    end

    def dictionary_path
      File.join(File.expand_path('../..', File.dirname(__FILE__)), 'config/words_dictionary.txt')
    end
  end
end