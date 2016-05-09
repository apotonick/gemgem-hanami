module Bootstrap
  module Cell
    class Layout < Trailblazer::Cell
      include ::Cell::Hamlit
      self.view_paths = ["./apps/web"]

      def controller
        context[:controller]
      end
    end
  end
end
