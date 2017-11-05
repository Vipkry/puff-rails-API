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

  # GET /stats
  def stats
    teacher = Teacher.find(params[:teacher_id])
    param_order = params[:param].to_i
    param = nil

    if param_order == 1
      param = Param.first
    elsif param_order == 2
      param = Param.second
    elsif param_order == 3
      param = Param.third
    else
      param = Param.last
    end

    if teacher && param
      rating = Rating.where('param_id = ? and teacher_id = ?', param.id, teacher.id).first
      months = []
      months << rating.create_at.month
      values = []
      values << rating.rate
      @result = [months, values]

      render json: @result
    else
      render json: nil, status: 404
    end


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
    
    feedback = Feedback.new(:text => params[:feedback], :teacher_id => params[:t].to_i, :user_id => params[:u])
    feedback.save
    
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
      sum = aux.sum(:rate).to_f
      cont = aux.count.to_f
      media = sum/cont.to_f
      tax = (100*media).to_f
      tax = (tax / 5.0).to_f.round(2)
      @result << tax
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
