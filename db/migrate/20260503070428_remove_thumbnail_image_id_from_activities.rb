class RemoveThumbnailImageIdFromActivities < ActiveRecord::Migration[8.1]
  def change
    remove_column :activities, :thumbnail_image_id, :integer
  end
end
