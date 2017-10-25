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

  # POST /rate
  def rate 
    all_params = Param.all
    ratings = params[:rating].split(//)
    u =  User.find_by(reg: params[:u])
    u_id = 0
    
    if u 
      u_id = u.id
    end
    
    @objs = []

    i = 0
    ratings.each do |rate|
      # rate chega em ordem assim : "445"
      @objs << Rating.new(:rate => rate.to_i, :teacher_id => params[:t].to_i, :user_id => u_id, :param_id => all_params[i].id)
      i = i + 1
    end
    
    @objs.each(&:save!)
    
    render json: @objs
  end


  def rating
    # 5 -> 100%
    # 1 -> 0%
    
    teacher_id = params[:teacher]
    param = Param.first(3)
    @result = []
    
    param.each do |pa|
      aux = Rating.where('teacher_id = ? and param_id = ?', teacher_id, pa.id)
      sum = aux.sum(:rate)
      cont = aux.count
      media = sum/cont
      # tax = (100*media)
      # tax = tax / 5.0
      @result << media
    end
  render json: @result  
    
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
