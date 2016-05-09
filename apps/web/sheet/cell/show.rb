module Web::Sheet
  module Cell
    class Show < Trailblazer::Cell
      include ::Cell::Hamlit
      self.view_paths = ["./apps"]

      def routes
        context[:routes]
      end

      property :title
      property :content
    end
  end
end

