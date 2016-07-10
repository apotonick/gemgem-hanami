# DB.extension :pg_array
# DB.extension :pg_json

Sequel::Model.plugin :timestamps
Sequel::Model.strict_param_setting = false
Sequel::Database.extension :pg_json
module Sheet
  class Persistence < Sequel::Model(:sheets)
  end
end

require "hamlit/block"

require "trailblazer/cells"
require_relative "../sheet/operation/create.rb"
require_relative "../sheet/operation/update.rb"
require_relative "../sheet/cell/new.rb"
require_relative "../sheet/cell/show.rb"
require_relative "../bootstrap/cell/layout.rb"

module Controller
  def self.included(includer)
    includer.send :include, Web::Action
    includer.send :include, Hanami::Assets::Helpers # FIXME.
  end

  # Render the content cell with the "app-wide" layout cell.
  def render(cell_constant, *args)
    self.body =
      cell_constant.(*args,
        context: { routes: routes, controller: self },
        layout:  Bootstrap::Cell::Layout
      ).()
  end
end


module Web::Controllers::Sheets
  class New
    include ::Controller

    def call(params)
      op = Sheet::Create.present({})

      # "prepopulate"
      op.contract.notes.append({})
      op.contract.notes.append({})
      op.contract.notes.append({})

      render Web::Sheet::Cell::New, op.contract
    end
  end

  class Create
    include ::Controller

    def call(params)
      op = Sheet::Create.run(params.to_h) do |op|
        redirect_to routes.sheet_path(op.model.id)
      end

      render Web::Sheet::Cell::New, op.contract
    end
  end

  class Update
    include ::Controller

    def call(params)
      op = Sheet::Update.run(params) do |op|
        redirect_to routes.sheet_path(op.model.id)
      end

      render Web::Sheet::Cell::New, op.contract
    end
  end

  class Show
    include ::Controller

    def call(params)
      op = Sheet::Update.present(params)

      # render Web::Sheet::Cell::Show, op.model
      render Web::Sheet::Cell::New, op.contract
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
