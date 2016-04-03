require "cells"
require_relative "../product/cell/new.rb"

module Web::Controllers::Product
  class New
    include Web::Action

    def call(params)
      self.body = "hello!"
    end
  end
end
