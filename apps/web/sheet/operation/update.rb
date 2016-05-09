  require_relative "create.rb"

  module Sheet
    class Update < Create
      model Sheet::Persistence, :update

      def update_model(params)
        model_class[params[:id]]
      end
    end
  end
