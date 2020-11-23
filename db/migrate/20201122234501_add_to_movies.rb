class AddToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :title, :string
    add_column :movies, :year, :string
    add_column :movies, :image, :string
  end
end
