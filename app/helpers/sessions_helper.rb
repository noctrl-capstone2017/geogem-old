# Authors Alexander Pavia + Matthew O + Debra J
module SessionsHelper

#Calculates session duration from start and end times
  def calculateDuration
    @session = Session.find(params[:id])
    start = Time.at(@session.start_time)
    endt = Time.at(@session.end_time)
    duration = endt - start
   
   return formatTime(duration)
  end

  # Authors Alexander Pavia + Matthew O + Debra J
  #If the square tracking type is an interval
  #insert yes if the student had behavior in the interval time 
  #Else insert no if the student did not have behavior in interval time
  def getInterval(square)
    @session = Session.find(params[:id])
    @student = Student.find(@session.session_student)
    @sessionEvent = SessionEvent.where(session_id: @session.id, behavior_square_id: square.id)
    answer = "No"
    if  @sessionEvent.length >= 1
      
      return answer = "Yes"
    end
    
    return answer
  end # end isInterval
  
  # Authors Alexander Pavia + Matthew O + Debra J
  #display the number of times square was pressed 
  #count where the session_id = the session_id and behavior_sq = behavior_sq
  def getFrequency(square)
    @session = Session.find(params[:id])
    
    #should just be the total number of session events for a certain square for that session
    @frequency = SessionEvent.where(session_id: @session.id, behavior_square_id: square.id).count
  
    return @frequency
  end # end isFrequency
  
  #@author Alex P + Matthew O + Debra J
  #gets the duration 
  def getDuration(square)
   
    @session = Session.find(params[:id])
    @sessionEvent = SessionEvent.where(session_id: @session.id, behavior_square_id: square.id)
    #total duration for the square
    totalDuration = 0
    
    #get the session Events for the square
    @sessionEvent.each do |event|
     start = Time.at(event.square_press_time)
     endt = Time.at(event.duration_end_time)
     eventDuration= endt - start
     totalDuration += eventDuration 
    end
   
    return totalDuration
  end # end method

end # end class 

 #@author Alex P + Matthew O + Debra J
 #formats the time
def formatTime(duration)
  #see if duration is at least a minute, if so format as minutes
   #else format as seconds
    if duration >= 60
        #show duration as minutes
      durationStr = Time.at(duration).utc.strftime("%-M:%S") + " minutes"
    else
      durationStr = durationStr = Time.at(duration).utc.strftime("%-S") + " seconds"
    end

    return durationStr
end