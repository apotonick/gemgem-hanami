require "disposable/twin/struct"
require "trailblazer/operation/model"

require "disposable/twin/property/hash"

module Sheet
  class Create < Trailblazer::Operation
    module Populator
      class Notes
        include Uber::Callable

        def call(fragment:, **)
          return skip! if fragment["text"] == "" # TODO: test me
          return notes.find { |n| n.id == id } if (id = fragment["id"]) && id != ""
          notes.append({ id: SecureRandom.hex(3), created_at: Time.now }) # TODO: test me
        end
      end
    end

    contract do
      include Disposable::Twin::Property::Hash

      property :title
      property :content, field: :hash do
        property :tags

        collection :notes, populator: Populator::Notes.new do
          property :text
          property :id, deserializer: { writeable: false }
          property :created_at
        end
      end

      unnest :tags, from: :content
      unnest :notes, from: :content


      # 1. mapped attributes have to be defined :virtual, so reform doesn't try to read/write them from/to the top model.
      # 2. in #validate, mapped attrs have to be defines so reform "sees" them in the incoming data.
      # 3. since we say #notes => content.notes, for existing top notes we always get a Struct nested form already, as this
      #    accesses the Struct data structure.
      # 4. the :populator is cool in the "virtual" top property, it knows about the Struct interface, though (maybe change?),
      #    that's why there's Hash.new
      # 5. again, content.notes gives us a nested Struct form so we actually don't need any block content for the top
      #    collection :notes block.


      # this is called in populator and returns a Struct object.
      # def notes
      #   content.notes
      # end

      # # needed to make reform process this field.
      # property :tags, virtual: true
    end

    include Model
    model ::Sheet::Persistence, :create # Sheet::Persistence

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
