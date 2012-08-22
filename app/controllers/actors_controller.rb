class ActorsController < ApplicationController
  # GET /actors
  # GET /actors.json
  def index
    @actors = Actor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @actors }
    end
  end

  # GET /actors/1
  # GET /actors/1.json
  def show
    @actor = Actor.find(params[:id])
    @others = Actor.where("id != ?", @actor.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actor }
    end
  end

end
