Hanami::Model.migration do
  change do
    add_column :sheets, :created_at, DateTime
    add_column :sheets, :updated_at, DateTime
  end
end
