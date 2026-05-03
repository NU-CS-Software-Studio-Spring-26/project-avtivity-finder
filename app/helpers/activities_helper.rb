module ActivitiesHelper
    def activity_image(activity)
        if activity.thumbnail.present?
            url_for(activity.thumbnail)
        else
            asset_path("activity_finder_default_thumbnail.jpg")
        end
    end
end
