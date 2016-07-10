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

      # test me, with new and updatable
      def last_updated_at
        return if model.model.created_at.nil?
        return %{Created #{model.model.created_at.strftime("%d %B %Y, %H:%M")}} if model.model.updated_at.nil?

        %{Last updated: #{model.model.updated_at.strftime("%d %B %Y, %H:%M")}}
      end

      def config
        { action: url, method: new? ? :post : :post }
      end
    end

  end
end

