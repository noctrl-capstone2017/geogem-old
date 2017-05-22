class SquaresController < ApplicationController
  
  # By Ricky Perez & Michael Loptien  
  
  include TeachersHelper
  
  before_action :set_square, only: [:show, :edit, :update, :destroy]
  before_action :set_school         #set up the school info for the logged in teacher
  before_action :is_admin
    
  # GET /squares
  # GET /squares.json
  def index
    # Check for Super User, shool_id == 0, list ALL squares
    if current_teacher.school_id == 0
      @squares = Square.all
    else                      #school admin. Only list that schools students
      @squares = Square.where(school_id: current_teacher.school_id)
    end
    
    # Paginate those squares and order by screen_name
    @squares = @squares.order('screen_name ASC')
    @squares = @squares.paginate(page: params[:page], :per_page => 10)
  end

  # GET /squares/1
  # GET /squares/1.json
  def show
  end

  # GET /squares/new
  def new
    @square = Square.new
  end

  # GET /squares/1/edit
  def edit
  end

  # POST /squares
  # POST /squares.json
  def create
    @square = Square.new(square_params)

    respond_to do |format|
      if @square.save
        format.html { redirect_to squares_url, notice: 'Square was successfully created.' }
        format.json { render :index, status: :created, location: @square }
      else
        format.html { render :new }
        format.json { render json: @square.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /squares/1
  # PATCH/PUT /squares/1.json
  def update
    respond_to do |format|
      if @square.update(square_params)
        format.html { redirect_to squares_url, notice: 'Square was successfully updated.' }
        format.json { render :index, status: :ok, location: @square }
      else
        format.html { render :edit }
        format.json { render json: @square.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /squares/1
  # DELETE /squares/1.json
  def destroy
    @square.destroy
    respond_to do |format|
      format.html { redirect_to squares_url, notice: 'Square was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_square
      @square = Square.find(params[:id])
    end

    # Used for getting the school values for the logged in teacher 
    def set_school
      if current_teacher.school_id == 0       #Super User
        @color  = current_teacher.color
        @full_name = current_teacher.full_name
        @icon = current_teacher.icon
      else                                    #Admin for school
        @school = School.find(current_teacher.school_id)
        @color  = @school.color
        @screen_name = @school.screen_name
        @icon = @school.icon
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def square_params
      params.require(:square).permit(:full_name, :screen_name, :color, :tracking_type, :description, :school_id)
    end
end
