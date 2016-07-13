module Bootstrap::Cell
  class Sidebar < Trailblazer::Cell
    include ::Cell::Slim

    def items
      ::Sheet::Persistence.all
    end
  end
end
