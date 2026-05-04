class AddThumbnailImageIdToActivities < ActiveRecord::Migration[8.1]
  def change
    add_column :activities, :thumbnail_image_id, :integer
  end
end
