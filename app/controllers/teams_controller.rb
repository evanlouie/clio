class TeamsController < ApplicationController
  before_filter :set_team, only: [:show, :edit, :update, :destroy]
  before_filter :valid_params, only: [:index]

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
    claim_users
    respond_with(@team)
  end

  def update
    @team.update_attributes(params[:team])
    claim_users
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

    def claim_users
      User.where(id: params[:user_id]).each do |u|
        u.team = @team
        u.save
      end
    end

    def valid_params
      errors = []
      errors.push("id must be array") if !params[:id].is_a?(Array) && params[:id]!=nil

      [params[:order]].flatten.each do |o|
        errors.push("#{o} is not a valid ordering attribute") unless ([nil]+Team.column_names).include?(o)
      end

      [params[:include]].flatten.each do |i|
        errors.push("#{i} is not a valid association") unless ([nil]+Team.reflect_on_all_associations.map{|r| r.name.to_s}).include?(i)
      end

      [params[:only]].flatten.each do |o|
        errors.push("#{o} is not a valid attribute") unless ([nil]+Team.column_names).include?(o)
      end

      raise ArgumentError, errors unless errors.size==0

    end
end
