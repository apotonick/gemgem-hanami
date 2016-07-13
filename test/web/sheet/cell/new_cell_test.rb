require 'test_helper'
require_relative '../../../../apps/web/controllers/sheets_controller'

# class Helpers
#   include Web::Action
#   include Hanami::Assets::Helpers # FIXME.
# end




describe Web::Sheet::Cell do
  include Cell::Testing

  describe "create new" do
    let (:op) { Sheet::Create.present({}) }

    it 'is successful' do
      controller = Web::Controllers::Sheets::New.new

      # Web::Sheet::Cell::New.(op.contract, context: { routes: controller.send(:routes) }).()
      html = cell(Web::Sheet::Cell::New, op.contract, context: { routes: controller.send(:routes) }).()
      html.wont_have_content /Last updated/
    end

  end

  describe "edit new" do
    let (:sheet) { Sheet::Create.(title: "Duran Duran").model }
    let (:op) { Sheet::Update.present(id: sheet.id) }

    it 'is successful' do
      controller = Web::Controllers::Sheets::New.new

      # Web::Sheet::Cell::New.(op.contract, context: { routes: controller.send(:routes) }).()
      html = cell(Web::Sheet::Cell::New, op.contract, context: { routes: controller.send(:routes) }).()

      html.must_have_css %{#title[value="Duran Duran"]}
      html.must_have_content /Created/
    end
  end

  describe "edit existing" do
    let (:sheet) do
      model = Sheet::Create.(title: "Duran Duran").model
      Sheet::Update.(id: model.id, title: "Duran Duran, y'all!").model
    end



    let (:op) { Sheet::Update.present(id: sheet.id) }

    it 'is successful' do

      controller = Web::Controllers::Sheets::New.new

      # Web::Sheet::Cell::New.(op.contract, context: { routes: controller.send(:routes) }).()
      html = cell(Web::Sheet::Cell::New, op.contract, context: { routes: controller.send(:routes) }).()

      html.must_have_css %{#title[value="Duran Duran, y'all!"]}
      html.must_have_content /Last updated/
    end
  end

end
