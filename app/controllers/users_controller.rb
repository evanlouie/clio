class UsersController < ApplicationController
  before_filter :only_myself, only: [:edit, :update]
  before_filter :set_user, only: [:status, :show, :edit, :update]
  before_filter :valid_params, only: [:index]

  respond_to :html, :json

  def index
    @users = User
    @users = @users.where({id: params[:id].map{|id| id.to_i }}) if params[:id]
    @users = @users.search(params[:query]) if params[:query]
    @users = @users.includes(:team).paginate(page: params[:page]).order(params[:order])
    respond_to do |f|
      f.html {}
      f.json do
        respond_with @users.includes(params[:include]).to_json(only: params[:only], include: params[:include])
      end
    end
  end

  def status
    respond_to do |format|
      format.json { respond_with @user.to_json(:only => [:id, :status], :methods => [:full_name]) }
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.json { respond_with @user.to_json(include: params[:include], only: params[:only])}
    end
  end

  def edit
  end

  def update
    @user.update_attributes(params[:user])
    respond_to do |format|
      format.html {redirect_to users_path}
      format.json { respond_with @user.to_json }
    end
  end

  private

  def only_myself
    unless current_user.id == params[:id].to_i
      flash[:alert] = "You can't edit other users' information."
      redirect_to users_path
    end
  end
  def set_user
    @user = User.find(params[:id])
  end

  def valid_params
    errors = []
    errors.push("id must be array") if !params[:id].is_a?(Array) && params[:id]!=nil

    [params[:order]].flatten.each do |o|
      errors.push("#{o} is not a valid ordering attribute") unless ([nil]+User.column_names).include?(o)
    end

    [params[:include]].flatten.each do |i|
      errors.push("#{i} is not a valid association") unless ([nil]+User.reflect_on_all_associations.map{|r| r.name.to_s}).include?(i)
    end

    [params[:only]].flatten.each do |o|
      errors.push("#{o} is not a valid attribute") unless ([nil]+User.column_names).include?(o)
    end

    raise ArgumentError, errors unless errors.size==0

  end


end
