# author: Dakota B and Robert H
# Some school methods, as well as some super stuff.

class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  # Used in the /schools route to display all schools
  def index
    @schools = School.paginate(page: params[:page], :per_page => 10)
  end

  # Used in the creation of new schools
  def new
    @school = School.new
  end

  # Used in the Super Dashboard to allow teacher 1 (profbill) to switch focus to any school
  def super
    @schools = School.all
    @teacher = Teacher.first
  end
  
  # Used to pass information about which school will be backed up to the /backup page
  def backup
    @current_teacher = current_teacher
    @school = School.find(current_teacher.school_id)
    @school_name = School.find(current_teacher.school_id).full_name
  end
  
  # Used to pass information about which teacher at what school will be backed up to the /suspend page
  def suspend
    @current_teacher = current_teacher
    # id = 1 written below refers to ProfBill, the SuperUser. He can't get deleted,
    # and therefore will never be in the set of teachers elligible for deletion
    @teachers = Teacher.where(school_id: current_teacher.school_id).where.not(id: 1) 
    @school = School.find(current_teacher.school_id)
    @school_name = School.find(current_teacher.school_id).full_name
    @teacher_count = @teachers.count
  end 

  # Used to pass information to the /restore page about which teachers at what school will be restored.
  def restore
    @current_teacher = current_teacher
    #id = 1 is ProfBill, the SuperUser. He can't get deleted in the first place. No point in restoring.
    @teachers = Teacher.where(school_id: current_teacher.school_id).where.not(id: 1) 
    @school = School.find(current_teacher.school_id)
    @school_name = School.find(current_teacher.school_id).full_name
    @teacher_count = @teachers.count
  end 
  
  # Used in addition the the new method in the creation of schools.
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

  # Used to update a School profile
  def update
      if @school.update(school_params)
        redirect_to schools_path, :notice => "School updated"
      else
        redirect_to schools_path, :notice => "School updated"
      end
  end

  private

    def set_school
      @school = School.find(params[:id])
    end
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:full_name, :screen_name, :icon, :color, :email, :website, :description)
    end
    
end # end of controller
