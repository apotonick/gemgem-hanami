Hanami::Model.migration do
  change do
    create_table :sheets do
      primary_key :id
      # foreign_key :author_id, :authors, on_delete: :cascade, null: false

      column :title, String
      column :content, "jsonb"

    end
  end
end
