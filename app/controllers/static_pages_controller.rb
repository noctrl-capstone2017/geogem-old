# Static Pages Controller
# Author: Meagan Moore & Steven Royster
  
  class StaticPagesController < ApplicationController
    skip_before_filter :require_login
        
    def about1
    end
    
    def about2
    end
    
    def help
    end
    
  end