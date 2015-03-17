class UsersController < ApplicationController
  before_filter :only_myself, only: [:edit, :update]

  respond_to :html, :json

  def index
    @users = User.includes(:team).without_user(current_user).paginate(page: params[:page])
    @users = @users.search(params[:query]) if params[:query]
    respond_to do |f|
      f.html {}
      f.json { respond_with(@users.unshift(current_user).to_json(only: [:id, :status], methods: [:full_name, :team]))}
    end
  end

  def status
    @user = User.find(params[:id])
    respond_to do |format|
      format.json { render :json =>  @user.to_json(:only => [:id, :status], :methods => [:full_name]) }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(params[:user])
    redirect_to users_path
  end

  private

  def only_myself
    unless current_user.id == params[:id].to_i
      flash[:alert] = "You can't edit other users' information."
      redirect_to users_path
    end
  end

end
