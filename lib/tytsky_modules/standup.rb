# coding: utf-8

module TytskyModules
  module Standup
    def self.included(base)
      base.register_method(:standup_time, 'Узнать когда будет стендап')
    end

    def standup_time
      if too_late_for_standup?
        "Без стендапа сегодня#{', но завтра точно будет.' unless weekend? }"
      else
        random_event || random_time
      end
    end

    private

    def random_event
      if rand(10) < 3
        ['Ждем Яну', 'Ждем Виталю', 'Проведите стендап без меня', 'Стендап!'].sample
      end
    end

    def random_time
      "Давайте стендап в 11:%02d" % (Time.now.hour < 11 ? rand(59) : rand(Time.now.min..59))
    end

    def too_late_for_standup?
      Time.now.hour > 12
    end

    def weekend?
      [1, 6, 7].include? Time.now.day
    end
  end
end