class MissionsController < ApplicationController
  before_filter :find_mission, only: [:show, :edit, :update]

  def index
    @missions = Mission.all
  end

  def show

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

private

  def find_mission
    @mission = Mission.friendly.find(params[:id])
  end

  def mission_params
    params.require(:mission).permit(:name, :team_id, :mission_patch)
  end
end
