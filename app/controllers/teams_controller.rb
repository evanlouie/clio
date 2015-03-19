class TeamsController < ApplicationController
  before_filter :set_team, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @teams = Team
    @teams = @teams.search(params[:query]) if params[:query]
    @teams = @teams.includes(:users).paginate(page: params[:page])
    respond_to do |format|
      format.html {}
      format.json do
        respond_with @teams.includes(params[:include]).to_json(include: params[:include], only: params[:only])
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
    # User.where(id: params[:user_id]).each do |u|
    #   u.team = @team
    #   u.save
    # end
    respond_with(@team)
  end

  def update
    @team.update_attributes(params[:team])
    # User.where(id: params[:user_id]).each do |u|
    #   u.team = @team
    #   u.save
    # end
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

    def set_users
      @users = User.where(id: params[:user_id]).all
    end
end
