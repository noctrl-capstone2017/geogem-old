module SessionsHelper
  def calculateDuration
    @session = Session.find(params[:id])
    start = Time.at(@session.start_time)
    endt = Time.now
    #endt= Time.at(@session.end_time)
    #duration = @session.end_time - @session.start_time
    duration = endt - start
    duration = Time.at(duration).utc.strftime("%H:%M")

    return duration
  end 
end
