#Authors Alex P, Matthew O, Debra J
module SessionsHelper
  #Calculates session duration from start and end times
  def calculateDuration
    @session = Session.find(params[:id])
    start = Time.at(@session.start_time)
    endt = Time.at(@session.end_time)
    duration = endt - start
    #Format duration as the number of minutes
    duration = Time.at(duration).utc.strftime("%M")
    return duration
  end
end