# author: Kevin M, Tommy B
# Teacher methods.
class TeachersController < ApplicationController

  before_action :set_teacher, only: [:show, :edit, :update, :destroy, :pword]
  before_action :is_admin, except: [:update, :edit]
  before_action :is_super, except: [:update, :edit]

  # GET /teachers
  # GET /teachers.json
  def index
    @current_teacher = current_teacher
    @teachers = Teacher.paginate(page: params[:page], :per_page => 10)
  end
  
  # GET /teachers/1
  # GET /teachers/1.json
  def show
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  def edit
  end
  
  # GET /teachers/1/password
  # When sessions and stuff are in place, only the teacher that this is for will
  # be able to access it. Not fully working yet.
  def password
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: 'Teacher was successfully created.' }
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
   
   #Robert Herrera
   # POST /super
  def updateFocus
    teacher = Teacher.find(1)
    
    if teacher.update(focus_school_params)
      format.html { redirect_to teachers_url, notice: 'Super School was successfully switched.' }
      teacher.full_name = params[full_name]
    else
      flash[:danger] = "Unauthorized"
        redirect_to home1_path
    end
  end
 
  private
  
    # Author: Steven Royster
    # If the teacher is not an admin then they 
    #  will be flashed an unauthorized prompt and redirected to home
    def is_admin
      if !is_admin?
        flash[:danger] = "Unauthorized"
        redirect_to login_path
      end
    end
    
    # Author: Steven Royster
    # Checks to see if the current teacher has admin status
    # Returns true if the teacher is an admin
    def is_admin?
      current_teacher && current_teacher.powers == "Admin"
    end
    
    # Author: Steven Royster
    # If the teacher is not a super user then they 
    #  will be flashed an unauthorized prompt and redirected to home
    def is_super
      if !is_super?
        flash[:danger] = "Unauthorized"
        redirect_to home1_path
      end
    end

     # Author: Steven Royster
    # Checks to see if the current teacher has super user status
    # Returns true if the teacher is a super user
    def is_super?
      current_teacher && current_teacher.id == 1
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:user_name, :password_digest, :last_login,
      :full_name, :screen_name, :icon, :color, :email, :description, :powers, 
      :school_id, :password, :password_digest)
    end
    
        # Switching the focus school 
    def focus_school_params 
      params.require(:full_name).permit(:school_id)
    end 
end