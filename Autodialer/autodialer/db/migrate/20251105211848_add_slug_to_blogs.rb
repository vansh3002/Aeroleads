class AddSlugToBlogs < ActiveRecord::Migration[8.1]
  def change
    add_column :blogs, :slug, :string
  end
end
