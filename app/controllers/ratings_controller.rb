class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :update, :destroy]

  # GET /ratings
  def index
    @ratings = Rating.all

    render json: @ratings
  end

  # GET /ratings/1
  def show
    render json: @rating
  end

  # POST /ratings
  def create
    @rating = Rating.new(rating_params)

    if @rating.save
      render json: @rating, status: :created, location: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ratings/1
  def update
    if @rating.update(rating_params)
      render json: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ratings/1
  def destroy
    @rating.destroy
  end

  # GET /rate
  def rate 
    all_params = Param.all
    ratings = params[:rating].to_s
    ratings = ratings.split(//)
    @objs = []

    i = 0
    ratings.each do |rate|
      # rate chega em ordem assim : "445"
      @objs << Rating.new(:rate => rate.to_i, :teacher_id => params[:t].to_i, :user_id => params[:u].to_i, :param_id => all_params[i].id)
      i = i + 1
    end
    
    @objs.each(&:save)
    
    render json: @objs
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rating_params
      params.require(:rating).permit(:rate, :user_id, :teacher_id, :param_id)
    end
end
