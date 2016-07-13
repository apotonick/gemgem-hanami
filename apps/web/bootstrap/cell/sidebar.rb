module Bootstrap::Cell
  class Sidebar < Trailblazer::Cell
    def items
      ::Sheet::Persistence.all
    end
  end
end
