require "disposable/twin/struct"
require "trailblazer/operation/model"

require "reform/form/active_model/validations"

module Sheet
  class Create < Trailblazer::Operation
    contract do
      feature Reform::Form::ActiveModel::Validations

      property :title

      property :content do
        include Disposable::Twin::Struct

        property :tags
      end


      #   collection :tags
      #   # property :tags
      # end

      property :tags, virtual: true
      def tags
        content.tags
      end

      def tags=(v)
        content.tags = v
      end
    end

    include Model
    model ::Sheet::Persistence, :create # Sheet::Persistence

    def model!(*)
      m= super
      m.content={tags: "sdf"}
      m
    end
  end
end
