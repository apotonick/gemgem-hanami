require "trailblazer/cells"
# require "cell/concept"
require_relative "../../product/cell/new.rb"

module Web::Controllers::Products
  class New
    include Web::Action

    def call(params)
      # raise routes.inspect
      self.body = Web::Product::Cell::New.(nil, routes: routes).()
    end
  end
end


# Web::Controllers::Product::New
# Web::Product::Controller::New
# routing and generators great
# reloading in dev fantastic!
# don't like the namespacing
