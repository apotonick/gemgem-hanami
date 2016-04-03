require 'spec_helper'
require_relative '../../../../apps/web/views/product/new'

describe Web::Views::Product::New do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/product/new.html.erb') }
  let(:view)      { Web::Views::Product::New.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
