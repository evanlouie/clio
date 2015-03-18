class TeamsController < ApplicationController
  before_filter :set_team, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @teams = Team.includes(:users).paginate(page: params[:page])
    respond_to do |format|
      format.html {}
      format.json do
        includes = symbolfy_array(params[:include])
        only = symbolfy_array(params[:only])
        respond_with @teams.includes(includes).to_json(include: includes, only: only)
      end
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.json { respond_with(@team.to_json(include: :users)) }
    end
  end

  def new
    @team = Team.new
    respond_with(@team)
  end

  def edit
  end

  def create
    @team = Team.new(params[:team])
    @team.save
    respond_with(@team)
  end

  def update
    @team.update_attributes(params[:team])
    respond_with(@team)
  end

  def destroy
    @team.destroy
    respond_with(@team)
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end
end
