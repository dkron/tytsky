# coding: utf-8
require 'singleton'
require './lib/tytsky_modules/talk'
require './lib/tytsky_modules/standup'
require './lib/tytsky_modules/work'
require './lib/tytsky_modules/magic'

class Tytsky
  include Singleton

  @@tytsky_methods = {}

  def self.register_method(method_name, method_description)
    @@tytsky_methods[method_name] = method_description
  end

  def help

    @@tytsky_methods.sort_by { |k, _| k }.map do |val|
      "#{val[0]} - #{val[1]}"
    end.join("\n")
  end
  register_method(:help, 'Справка по доступным действиям')

  include TytskyModules::Talk
  include TytskyModules::Standup
  include TytskyModules::Work
  include TytskyModules::Magic
end