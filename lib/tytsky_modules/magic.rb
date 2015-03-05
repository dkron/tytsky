# coding: utf-8

module TytskyModules
  module Magic
    SPELLS = %w(avada-kedavra accio alohomora crucio descendo expecto-patronum expelliarmus redukto sectumsempra)

    def self.included(base)
      base.register_method(:cast, 'Случайное заклинание из HP')
    end

    def cast
      random_spell.upcase.concat('!')
    end

    private

    def random_spell
      SPELLS.sample
    end
  end
end