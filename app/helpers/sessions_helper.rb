module SessionsHelper
  def calculateDuration
    @session = Session.find(params[:id])
    start = Time.at(@session.start_time)
    endt = Time.at(@session.end_time)
    duration = endt - start
    duration = Time.at(duration).utc.strftime("%M")
    return duration
  end
end