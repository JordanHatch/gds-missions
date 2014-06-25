class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      flash.notice = "Team has been created"
      redirect_to teams_path
    else
      render action: :new
    end
  end

private
  def team_params
    params.require(:team).permit(:name)
  end
end
