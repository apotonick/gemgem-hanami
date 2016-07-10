module Web::Sheet
  module Cell
    # class New < ::Cell::Concept
    class New < Trailblazer::Cell
      include ::Cell::Hamlit
      self.view_paths = ["./apps"]

      def sheet
        model.model
      end

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
        return if sheet.created_at.nil?
        return %{Created #{date}} if sheet.updated_at.nil?
        %{Last updated: #{date}}
      end

      def date
        sheet.created_at.strftime("%d %B %Y, %H:%M")
      end


      def config
        { action: url, method: new? ? :post : :post }
      end
    end

  end
end

