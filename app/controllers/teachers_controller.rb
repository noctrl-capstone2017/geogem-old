# author: Kevin M, Tommy B
# Teacher methods.
class TeachersController < ApplicationController
  
  include TeachersHelper

  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  before_action :same_school, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, except: [:home, :update, :edit, :edit_password, :update_password]
  before_action :is_super, except: [:home, :update, :edit, :edit_password, :update_password]

  # GET /teachers
  # GET /teachers.json
  def index
    @current_teacher = current_teacher
    @teachers = Teacher.where(school_id: @current_teacher.school_id).paginate(page: params[:page], :per_page => 10)
  end
  
  def admin_report
    @students = Student.all
    @teachers = Teacher.all
    @squares = Square.all
  end
  
  # GET /teachers/1
  # GET /teachers/1.json
  def show
    @teacher = Teacher.find(params[:id])
    @students = @teacher.students
    @all_students_at_school = Student.where(school_id: @teacher.school_id)
    @students_not_in_roster_but_at_school = Student.where(school_id: @teacher.school_id).where.not(id: @teacher.students)
    
    if params[:add_student]
      @teacher.students.add(Student.find(@student_id))
    elsif params[:remove_student]
      @teacher.students.remove(Student.find(@student_id))
    end
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  def edit
  end
  
  # GET /teachers/password
  #author: Tommy B, Kevin M
  #utilized http://stackoverflow.com/questions/25490308/ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  def edit_password
    @teacher = current_teacher
  end
  
  #author: Tommy B, Kevin M
  #utilized http://stackoverflow.com/questions/25490308/ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  # Note from Tommy B: the redirects need to be changed
  def update_password
    teacher = current_teacher
    # also in here i'm calling the authenticate method that usually is present in bcrypt.
    if teacher and teacher.authenticate(params[:old_password])
      if params[:password] == params[:password_confirmation]
        teacher.password = BCrypt::Password.create(params[:password])
        if teacher.save!
          redirect_to @teacher, :flash => { :notice => "Password changed." }
        end
      else
        redirect_to @teacher, :flash => { :danger => "Incorrect Password." }
      end
    else
      redirect_to @teacher, :flash => { :danger => "Incorrect Password." }
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
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
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