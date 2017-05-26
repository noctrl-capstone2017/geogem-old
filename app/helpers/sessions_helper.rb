#Authors Alex P, Matthew O, Debra J
module SessionsHelper
  #Calculates session duration from start and end times
  def calculateDuration sess
    @session = Session.find(sess)
    start = Time.at(@session.start_time)
    endt = Time.at(@session.end_time)
    duration = endt - start
   
   #see if duration is at least a minute, if so format as minutes
   #else format as seconds
    if duration >= 60
        #show duration as minutes
      durationStr = Time.at(duration).utc.strftime("%M") + " minutes"
    else
      durationStr = durationStr = Time.at(duration).utc.strftime("%S") + " seconds"
    end

    return durationStr
  end
end