require "disposable/twin/struct"
require "trailblazer/operation/model"

module Sheet
  class Create < Trailblazer::Operation
    contract do
      property :title
      property :content do
        include Disposable::Twin::Struct
        collection :tags
      end
    end

    include Model
    model ::Sheet::Persistence, :create # Sheet::Persistence
  end
end
