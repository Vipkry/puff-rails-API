class TeachersController < ApplicationController
  # GET /teachers
  def index
    @teachers = Teacher.order(:name)

    render json: @teachers
  end

  # GET /teachers/1
  def show
    render json: @teacher
  end
end
