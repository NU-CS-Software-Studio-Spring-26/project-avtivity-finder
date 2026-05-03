class ActivitiesController < ApplicationController
  before_action :require_login, :set_activity, only: %i[ show edit update destroy ]
  before_action :set_activity, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_activity!, only: [ :edit, :update, :destroy ]

  def authorize_activity!
    redirect_to root_path, alert: "Not authorized" unless @activity.user == current_user
  end

  # GET /activities or /activities.json
  def index
    @activities = Activity.all
    # @activities = current_user.activities
  end

  # GET /activities/1 or /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities or /activities.json
  def create
    @activity = current_user.activities.build(activity_params)

    if @activity.save
      attach_new_images
      normalize_image_positions
      redirect_to activities_path, notice: "Activity created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    if @activity.update(activity_params)
      purge_selected_images
      attach_new_images
      update_image_order
      normalize_image_positions
      redirect_to activities_path, notice: "Activity updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /activities/1 or /activities/1.json
  def destroy
    @activity.destroy!

    respond_to do |format|
      format.html { redirect_to activities_path, notice: "Activity was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.expect(activity: [
          :title,
          :description,
          :location,
          :city,
          :category,
          :event_date
        ])
    end

    def attach_new_images
      uploaded_images = params.dig(:activity, :images)
      return if uploaded_images.blank?
      remaining_slots = 10 - @activity.images.attachments.count
      images_to_attach = uploaded_images.first(remaining_slots)
      @activity.images.attach(images_to_attach)
    end

    def purge_selected_images
      ids = params.dig(:activity, :remove_image_ids)&.reject(&:blank?) || []
      ids.each do |id|
        attachment = @activity.images.attachments.find_by(id: id)
        attachment&.purge
      end
    end

    def update_image_order
      ordered_ids = params.dig(:activity, :image_order)&.reject(&:blank?) || []
      ordered_ids.each_with_index do |id, index|
        attachment = @activity.images.attachments.find_by(id: id)
        attachment&.update(position: index + 1)
      end
    end

    def normalize_image_positions
      @activity.images.attachments.order(:position, :created_at).each_with_index do |attachment, index|
        attachment.update(position: index + 1)
      end
    end
end
