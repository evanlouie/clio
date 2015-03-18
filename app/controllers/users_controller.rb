class UsersController < ApplicationController
  before_filter :only_myself, only: [:edit, :update]
  before_filter :set_user, only: [:status, :show, :edit, :update]

  respond_to :html, :json

  def index
    @users = User
    @users = @users.where({id: params[:ids].split(',').map{|id| id.to_i }}) if params[:ids]
    @users = @users.search(params[:query]) if params[:query]
    @users = @users.includes(:team).paginate(page: params[:page])
    respond_to do |f|
      f.html {}
      f.json do
        includes = symbolfy_array(params[:include])
        only = symbolfy_array(params[:only])

        respond_with @users.includes(includes).to_json(only: only, include: includes)
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
      format.json { respond_with @user.to_json(include: :team)}
    end
  end

  def edit
  end

  def update
    @user.update_attributes(params[:user])
    redirect_to users_path
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


end
