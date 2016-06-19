module Web::Sheet
  module Cell
    # class New < ::Cell::Concept
    class New < Trailblazer::Cell
      include ::Cell::Hamlit
      self.view_paths = ["./apps"]

      # def show
      #   # "cells rule!"
      #   render :new
      # end
      def routes
        context[:routes]
      end

      def url
        new? ? routes.sheets_path : routes.sheet_path(model.model.id)
      end

      def new?
        model.model.new?
      end

      def config
        { action: url, method: new? ? :post : :post }
      end
    end

  end
end

