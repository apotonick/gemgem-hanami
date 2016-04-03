require 'spec_helper'
require_relative '../../../../apps/web/controllers/product/new'

describe Web::Controllers::Product::New do
  let(:action) { Web::Controllers::Product::New.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
