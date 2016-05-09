require "trailblazer/cells"
# require "cell/concept"
require_relative "../../product/cell/new.rb"
require_relative "../../foundation/cell/layout.rb"



# DB.extension :pg_array
# DB.extension :pg_json

Sequel::Model.strict_param_setting = false
class Sheet < Sequel::Model
end

Sheet.db.extension :pg_json

module Web::Controllers::Products
  class New
    include Web::Action

    include Hanami::Assets::Helpers # FIXME.

    def call(params)
      self.body =
        Web::Product::Cell::New.(nil,
          context: { routes: routes, controller: self },
          layout:  Foundation::Cell::Layout
        ).()
    end
  end
end

# class Assets
#   include Hanami::Assets::Helpers
# end

# Web::Controllers::Product::New
# Web::Product::Controller::New
# routing and generators great
# reloading in dev fantastic!
# don't like the namespacing
