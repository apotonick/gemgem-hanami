# DB.extension :pg_array
# DB.extension :pg_json

Sequel::Model.strict_param_setting = false
module Sheet
  class Persistence < Sequel::Model(:sheets)
  end
end

Sheet::Persistence.db.extension :pg_json


require "trailblazer/cells"
# require "cell/concept"
require_relative "../../sheet/operation/create.rb"
require_relative "../../sheet/cell/new.rb"
require_relative "../../bootstrap/cell/layout.rb"




module Web::Controllers::Sheets
  class New
    include Web::Action

    include Hanami::Assets::Helpers # FIXME.

    def call(params)
      op = Sheet::Create.present({})


      self.body =
        Web::Sheet::Cell::New.(nil,
          context: { routes: routes, controller: self },
          layout:  Bootstrap::Cell::Layout
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
