class SuperController < ApplicationController
   
   
  def index
  end

  def super
    @schools = School.all
  end
  
  def updateFocus

  end
  
  
  #Robert H
  # Confirms an admin user.
  ##   redirect_to(root_url) unless current_user.admin_powers?
  #end
end


