class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.paginate(page: params[:page], :per_page => 10)
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # RH
  # make the list of schools available at /super
  def super
    @schools = School.all
    @teacher = Teacher.first
  end
  
  def super_report
  end
  
  def backup
    @schools = School.all
  end
  
  def suspend
    @current_teacher = current_teacher
    #id = 1 written below refers to ProfBill, the SuperUser. He can't get deleted, and therefore will never be in the set of teachers elligible for deletion
    @teachers = Teacher.where(school_id: current_teacher.school_id).where.not(id: 1) 
    @school = School.find(current_teacher.school_id)
    @school_name = School.find(current_teacher.school_id).full_name
    @teacher_count = @teachers.count
  end 

  def restore
    @current_teacher = current_teacher
    @teachers = Teacher.where(school_id: current_teacher.school_id).where.not(id: 1) #id = 1 is ProfBill, the SuperUser. He can't get deleted.
    @school = School.find(current_teacher.school_id)
    @school_name = School.find(current_teacher.school_id).full_name
    @teacher_count = @teachers.count
  end 
  

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
      if @school.update(school_params)
        redirect_to schools_path, :notice => "School updated"
      else
        redirect_to schools_path, :notice => "School updated"
      end
  end


  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

   def set_school
      @school = School.find(params[:id])
   end
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:full_name, :screen_name, :icon, :color, :email, :website, :description)
    end
    
 
end
