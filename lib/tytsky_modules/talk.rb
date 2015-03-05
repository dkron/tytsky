# coding: utf-8
require 'base64'

module TytskyModules
  module Talk
    def talk
      random_word.force_encoding('UTF-8')
    end

    private

    def random_word
      Base64.decode64(words_dictionary.sample)
    end

    def words_dictionary
      @words_dictionary ||= File.readlines(dictionary_path)
    end

    def dictionary_path
      File.join(File.expand_path('../..', File.dirname(__FILE__)), 'config/words_dictionary.txt')
    end
  end
end