# coding: utf-8
require 'singleton'
require './lib/tytsky_modules/talk'
require './lib/tytsky_modules/standup'

class Tytsky
  include Singleton
  include TytskyModules::Talk
  include TytskyModules::Standup

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
end