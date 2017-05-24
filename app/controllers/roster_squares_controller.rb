class RosterSquaresController < ApplicationController
  before_action :set_roster_square, only: [:show, :edit, :update, :destroy]
  helper_method :set_square_name
  helper_method :set_square_color
  helper_method :set_square_id
  helper_method :set_square_desc
  helper_method :set_roster_id
  helper_method :is_student_square
  # GET /roster_squares
  # GET /roster_squares.json
  def index
    @roster_squares = RosterSquare.all
  end

  # GET /roster_squares/1
  # GET /roster_squares/1.json
  def show
    
  end

  # GET /roster_squares/new
  def new
    @roster_square = RosterSquare.new
  end

  # GET /roster_squares/1/edit
  def edit
    #Get set of squares and students to be used in roster squares.
    @roster_square = RosterSquare.new
    @roster_squares = RosterSquare.all
    @students = Student.find_by_id(params[:id])
    @student_squares = RosterSquare.where(student_id: @students.id)
    @school_squares = Square.where(school_id: @students.school_id)
    @square = Square.find_by_id(params[:id])
    @squares = Square.all
    #@not_student_squares = Square.where.not(id: @student_squares.find(student_id).square_id)
  end
  
  #Below are helpers methos that when called allow you to check certain fields
  #that would otherwise be unavailable
  def set_roster_id (roster_square)
    @roster_id = RosterSquare.find(roster_square.square_id).screen_name
  end
  
  def set_square_id (roster_square)
    @square_id = Square.find(roster_square.square_id).id
  end
  
  def set_square_desc (roster_square)
    @square_desc = Square.find(roster_square.square_id).full_name
  end
  
  def set_square_name (roster_square)
    @square_name = Square.find(roster_square.square_id).screen_name
  end
  
  def set_square_color (roster_square)
    @square_color = Square.find(roster_square.square_id).color
  end
  
  def is_student_square(square)
    @is_square = false
    @student_squares.each do |student_square|
    @is_square = false
      if square.id == student_square.square_id
        @is_square = true
        break
      end
      
      if @is_square != true
        @is_square = false
      end 
      
    end
    @is_square
  end
  
  # POST /roster_squares
  # POST /roster_squares.json
  def create
    @roster_square = RosterSquare.new(roster_square_params)
    @students = Student.find_by_id(params[:id])
    @squares = Square.all
    @square = Square.find_by_id(params[:id])
    @student_squares = RosterSquare.where(student_id: @students)
    respond_to do |format|
      if @roster_square.save
        format.html { redirect_to "/roster_squares/#{@roster_square.student_id}/edit", notice: 'Roster square was successfully created.' }
        format.json { render :edit, status: :created, location: @roster_square }
      else
        format.html { render :new }
        format.json { render json: @roster_square.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roster_squares/1
  # PATCH/PUT /roster_squares/1.json
  def update
    respond_to do |format|
      if @roster_square.update(roster_square_params)
        format.html { redirect_to "/roster_squares/#{@roster_square.student_id}/edit", notice: 'Roster square was successfully updated.' }
        format.json { render :show, status: :ok, location: @roster_square }
      else
        format.html { render :edit }
        format.json { render json: @roster_square.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roster_squares/1
  # DELETE /roster_squares/1.json
  def destroy
    @roster_square.destroy
    respond_to do |format|
      format.html { redirect_to  "/roster_squares/#{@roster_square.student_id}/edit", notice: 'Roster square was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roster_square
      @students = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roster_square_params
      params.require(:roster_square).permit(:square_id, :student_id)
    end
  
end