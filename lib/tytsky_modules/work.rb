# coding: utf-8

module TytskyModules
  module Work
    def self.included(base)
      base.register_method(:command, 'Дать указание что делать')
    end

    def command
      'Делай задачу BPC-%d. Я пока уточню приоритеты...' % random_task_number
    end

    private

    def random_task_number
      rand(5000..6000)
    end
  end
end