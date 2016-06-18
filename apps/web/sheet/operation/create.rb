require "disposable/twin/struct"
require "trailblazer/operation/model"

require "reform/form/dry"

module Sheet
  class Create < Trailblazer::Operation
    contract do
      # include Reform::Form::Composition

      feature Reform::Form::Dry

      property :title#, on: :sheet
      # property :tags, on: :content


      property :content do
        include Disposable::Twin::Struct

        property :tags

        collection :notes do
          include Disposable::Twin::Struct
          property :text
        end
      end

      # property :tags, virtual: true
      def tags
        content.tags
      end

      def tags=(v)
        # raise v.inspect
        content.tags = v
      end


      # 1. mapped attributes have to be defined :virtual, so reform doesn't try to read/write them from/to the top model.
      # 2. in #validate, mapped attrs have to be defines so reform "sees" them in the incoming data.
      # 3. since we say #notes => content.notes, for existing top notes we always get a Struct nested form already, as this
      #    accesses the Struct data structure.
      # 4. the :populator is cool in the "virtual" top property, it knows about the Struct interface, though (maybe change?),
      #    that's why there's Hash.new
      # 5. again, content.notes gives us a nested Struct form so we actually don't need any block content for the top
      #    collection :notes block.
      Note = Struct.new(:text)
      # we need to define notes on top-level as reform would ignore this otherwise.
      collection :notes, virtual: true, populator: ->(options) { notes.append Hash.new } do
        # include Disposable::Twin::Struct
        # property :text # not needed since the returned twin in the populator is the original one from above!
      end

      # this is called in populator and returns a Struct object.
      def notes
        content.notes
      end

      # needed to make reform process this field.
      property :tags, virtual: true
    end

    include Model
    model ::Sheet::Persistence, :create # Sheet::Persistence

    def model!(*)
      m= super
      puts "@@@@@ #{m.inspect}"
      m.content={ notes: [] } unless m.content
      m
    end

    # class Content < Disposable::Twin
    #   property :content
    # end

    # def contract!(model, options, contract_class)
    #   contract_class.new(sheet: model, content: Disposable::Twin::model.content)
    # end

    def process(params)
      validate(params.to_h) do
        puts "@@@cc #{contract.tags.inspect}"
        contract.save
      end
    end
  end
end
