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
    # @activity = Activity.new(activity_params)
    @activity = current_user.activities.build(activity_params)

    if @activity.save
      redirect_to @activity
    else
      render :new
    end
  end

  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: "Activity was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
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
      params.expect(activity: [ :title, :description, :location, :city, :category, :event_date ])
    end
end
