class TeamsController < ApplicationController
  before_filter :set_team, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @teams = Team.includes(:users).all
    respond_with(@teams)
  end

  def show
    respond_with(@team)
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
