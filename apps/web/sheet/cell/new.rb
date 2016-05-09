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
    end

  end
end

