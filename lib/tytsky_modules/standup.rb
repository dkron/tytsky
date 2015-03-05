# coding: utf-8
require 'base64'

module TytskyModules
  module Standup
    def standup?
      if !((text = random_event).nil?)
        text
      elsif Time.now.hour < 11
        "Давайте стендап в 11:%02d" % rand(59)
      elsif Time.now.hour < 12
        "Давайте стендап в 11:%02d" % rand(Time.now.min..59)
      else
        "Без стендапа сегодня"
      end
    end

    private

    def random_event
      if rand(10) < 3
        ['Ждем Яну', 'Ждем Виталю', 'Проведите стендап без меня'].sample
      end
    end
  end
end