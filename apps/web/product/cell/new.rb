module Web::Product
  module Cell
    # class New < ::Cell::Concept
    class New < Trailblazer::Cell
      include ::Cell::Hamlit
      self.view_paths = ["./apps"]

      # def show
      #   # "cells rule!"
      #   render :new
      # end
    end
  end
end

