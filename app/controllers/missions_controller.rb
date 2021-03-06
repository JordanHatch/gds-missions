class MissionsController < ApplicationController
  before_filter :find_mission, only: [:show, :edit, :update, :complete]
  before_filter :authenticate!, except: [:index, :in_progress, :show, :random]

  respond_to :html, :json

  def index
    @completed = Mission.completed.in_completion_order
    respond_with @completed
  end

  def in_progress
    @in_progress = Mission.in_progress
  end

  def show
    respond_with @mission
  end

  def random
    redirect_to mission_path(Mission.random, format: params[:format])
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      flash.notice = "Mission has been created"
      redirect_to mission_path(@mission)
    else
      render action: :new
    end
  end

  def edit

  end

  def update
    if @mission.update_attributes(mission_params)
      flash.notice = "Mission has been saved"
      redirect_to mission_path(@mission)
    else
      render action: :edit
    end
  end

  def complete
    if @mission.complete!
      flash.notice = "Mission has been marked as completed"
    else
      flash.error = "Mission could not be marked as completed"
    end

    redirect_to mission_path(@mission)
  end

private

  def find_mission
    @mission = Mission.friendly.includes(:team).find(params[:id])
  end

  def mission_params
    params.require(:mission)
          .permit(:name, :team_id, :mission_patch, :state, :short_description, :completed_on,
                  links_attributes: [:title, :url, :id, :_destroy])
  end
end
