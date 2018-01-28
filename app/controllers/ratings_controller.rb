class RatingsController < ApplicationController

  skip_before_action :authenticate, :only => [:rating]

  # GET /stats
  def stats
    if !@current_user.teacher
      render json: nil, status: 404
    end

    teacher = @current_user
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
      ratings = Rating.where('param_id = ? and teacher_id = ?', param.id, teacher.id).order(:created_at)
      months = []
      values = []
      contador_ratings_array = []

      contador_meses = 0
      
      ratings.each do |rating|
        actual_month = rating.created_at.strftime("%b")
        
        if !months.include?(actual_month)
          contador_meses += 1
          months << actual_month 
        end

        # se não houve nova inserção de meses, adiciona a avaliação.
        if values[contador_meses]
          values[-1] += rating.rate
          contador_ratings_array[-1] += 1
        # se houver inserção de meses, adiciona um novo item na array e reseta o contador
        else
          values << rating.rate
          contador_ratings_array << 1
        end  
      end

      # itera os valores para dividir pelo numero de 
      # ratings e obter a media aritimetica
      i = 0
      values.each do |value|
        values[i] = value/contador_ratings_array[i]
        i += 1
      end

      @result = [months, values]

      render json: @result
    else
      render json: nil, status: 404
    end
  end

  # POST /rate
  def rate 
    all_params = Param.all
    ratings = params[:rating].split(//)
    
    @objs = []

    i = 0
    ratings.each do |rate|
      # rate chega em ordem assim : "445"
      @objs << Rating.new(:rate => rate.to_i, :teacher_id => params[:t].to_i, :user_id => @current_user.id, :param_id => all_params[i].id)
      i = i + 1
    end
    
    @objs.each(&:save!)
    
    feedback = Feedback.new(:text => params[:feedback], :teacher_id => params[:t].to_i, :user_id => params[:u])
    feedback.save
    
    render json: @objs
  end

  # GET /rating
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
end
