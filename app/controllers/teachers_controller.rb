# author: Kevin M, Tommy B
# Teacher methods.
class TeachersController < ApplicationController
  
  include TeachersHelper
  include LoginSessionHelper
    
  #Before actions to reduce access and prime pages to show teacher info.
  before_action :set_teacher, only: [:show, :edit, :update]
  before_action :same_school, only: [:show, :edit, :update]
  #before_action :is_admin, except: [:home, :update, :edit, :edit_password, :update_password]
  #before_action :is_super, except: [:index, :home, :update, :edit, :edit_password, :update_password]

  # GET /teachers
  # GET /teachers.json
  def index
    @current_teacher = current_teacher
    @teachers = Teacher.where(school_id: @current_teacher.school_id).paginate(page: params[:page], :per_page => 10)
  end
  
  def admin_report
    @current_teacher = current_teacher
    @students = Student.where(school_id: current_teacher.school_id)
    @teachers = Teacher.where(school_id: current_teacher.school_id)
    @squares = Square.where(school_id: current_teacher.school_id)
  end
  
  # GET /teachers/1
  # GET /teachers/1.json
  def show
    @teacher = Teacher.find(params[:id])
    @students = @teacher.students.order('full_name ASC')
    @students_at_school = Student.where(school_id: @teacher.school_id).order('full_name ASC')
    @students_not_in_roster = Student.where(school_id: @teacher.school_id).where.not(id: @teacher.students).order('full_name ASC')
    
    if @teacher.powers == "Admin"
      @students = @students_at_school
      @students_not_in_roster = []
    end
    
    #Admins always have every student, so they can't add or remove from any admins.
    if params[:add_student]
        if params[:add_student_id != nil]
          if @teacher.powers != "Admin"
            @teacher.students << Student.find(params[:add_student_id])
          end
        end
        
    elsif params[:remove_student]
      if params[:remove_student_id != nil]
        if @teacher.powers != "Admin"
          @teacher.students.delete(Student.find(params[:remove_student_id]))
        end
      end
    end
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  def edit
  end
  
  def admin
    @teacher = current_teacher
  end 
  
  # GET /teachers/password
  # This prepares the password change page. It will always show the current user's,
  # even if they try to access it with another ID via /teachers/id/edit_password.
  # Used http://stackoverflow.com/questions/25490308/ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  def edit_password
    @teacher = current_teacher
  end
  
  # This updates the Teacher's password.
  # Used http://stackoverflow.com/questions/25490308/ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  def update_password
    teacher = current_teacher
    # also in here i'm calling the authenticate method that usually is present in bcrypt.
    if teacher and teacher.authenticate(params[:old_password])
      if params[:password] == params[:password_confirmation]
        teacher.password = BCrypt::Password.create(params[:password])
        if teacher.save!
          redirect_to teacher_edit_path, :flash => { :notice => "Password changed." }
        end
      else
        redirect_to teacher_edit_password_path, :flash => { :danger => "Incorrect Password." }
      end
    else
      redirect_to teacher_edit_password_path, :flash => { :danger => "Incorrect Password." }
    end
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, :flash => { :notice => "Teacher was successfully created." } }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end


  #author: Matthew O & Alex P
  #home page for teachers, display top 8 most used students, route to anaylze or new session
  def home
    @teacher = current_teacher
    @top_students = Student.where(id: Session.where(session_teacher: @teacher.id).group('session_student').order('count(*)').select('session_student').limit(8))
    if params[:start_session]
        @session = Session.new
        @session.session_teacher = @teacher.id
        @session.session_student = params[:student_id]
        @session.start_time = Time.now
        respond_to do |format|
          if @session.save
            format.html { redirect_to @session, notice: 'Session was successfully created.' }
            format.json { render :show, status: :created, location: @session }
          else
            format.html { render :new }
            format.json { render json: @session.errors, status: :unprocessable_entity }
          end
        end
    elsif params[:analyze]
        redirect_to analysis_path
    end
  end
  
  
  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to teachers_path, notice: 'Teacher was successfully updated.' }
        format.json { render :show, status: :ok, location: @teacher }
      else
        format.html { render :edit }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'Teacher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
   
   # make list of all schools available here so I can query them and set the super users schools attr 
   def super
    @schools = School.all
   end
   #Robert Herrera
   # POST /super
  def updateFocus
    teacher = Teacher.find(1)
    schoolName = params[full_name]
    teacher.full_name = schoolName

  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:user_name, :last_login,
      :full_name, :screen_name, :icon, :color, :email, :description, :powers, 
      :school_id, :password, :password_confirmation)
    end
    
    #Can only access teachers and info from the same school
    def same_school
      if current_teacher.school_id != Teacher.find(params[:id]).school_id
        redirect_to home_path, notice: "You can't access other schools."
      end
    end
    
    # Switching the focus school 
    def focus_school_params 
      params.require(:full_name).permit(:school_id)
    end 
end
