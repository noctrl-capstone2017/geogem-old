#Author: Taylor Spino
class ReportsController < ApplicationController

def report1
#Eventually going to refactor this so this type of report is in its own class
#Right? That way we can have methods for each table like last years's class

#Right now, the FIRST table only shows events that occured in between the
#session START and END time.

#The SECOND and THIRD tables show ANY duration events and notes, respectively,
#that happened during the session.

#It's moderately useful for debugging, but I can easily change this if we 
#want to.

pdf = Prawn::Document.new
pdf.font "Helvetica"

# Defining the grid (this might not be needed in the long run)
# See http://prawn.majesticseacreature.com/manual.pdf
pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 


                      # -------Session Data---------#
#for now, just grab the last seeded session
session = Session.last
student = Student.find(session.session_teacher)
teacher = Teacher.find(session.session_student)

#each square pressed for the current session of interest
#we are just using the session with ID 1 right now
eventsOccurred = SessionEvent.where(session_id: session.id)

                      # -------Header Info---------#

pdf.text "Behavior Session Summary", :size => 14, :align => :center

pdf.grid([0,0], [0,1]).bounding_box do
  pdf.text " "
  pdf.text "Student Name: " + student.full_name , :align => :left
  pdf.text "Teacher Name: " + teacher.full_name , :align => :left
end

#Bounding box is confusing, other ideas for multi-column are greatly appreciated
pdf.grid([0,0], [0,4]).bounding_box do 
  pdf.text " "
  pdf.text "Date: #{session.start_time.to_date}", :align => :right
  pdf.text "Time: " + session.start_time.strftime("%I:%M%p") + " - " +
                      session.end_time.strftime("%I:%M%p"), :align => :right
end

                      # -------ENTIRE SUMMARY TABLE---------#

#header is the first row for our table, will have this format:
#[TIME, BehaviorSquare1, BS2, BS3, ...]
header = Array.new
rows = Array.new{Array.new}


#we should be able to use this instead of header
stud_squares = Array.new
roster_squaresMap = RosterSquare.where(student_id: student.id)

roster_squaresMap.each do |map_square|
  stud_squares.push(Square.find(map_square.square_id))
end


#for each square pressed in the session
eventsOccurred.each do |event|
 
 #add the SQUARE object to the header array
 if header.exclude? Square.find(event.behavior_square_id)

   header.push(Square.find(event.behavior_square_id ))
   
 end 
  
end

#SORT the header array by square TYPE
#Will sort by duration, then frequency, then interval
header.sort! { |a,b| a.tracking_type  <=> b.tracking_type}

stud_squares.sort! { |a,b| a.tracking_type  <=> b.tracking_type}

#Let's start doing some actual data rows for our table

startI = session.start_time

#Grab student interval time

stud_interval = student.session_interval 

#MAKE SUPER SHORT INTERVALS FOR DEBUGGING
#stud_interval = 0.5

#adds stud_interval minutes to the start time
endI = session.start_time + stud_interval*60

eventsArray = Array.new

#make it an array instead of map, 
#was getting weird errors with truth statements when using the map
eventsOccurred.each do |event|
        eventsArray.push(event)
      end

one_time_loop = false
if(TimeDifference.between(session.start_time, 
                            session.end_time).in_minutes < stud_interval)
one_time_loop = true
end

#while endI <= session.end_time
#DEBUGGING, adding an hour just so we can have a couple of rows
while (endI <= session.end_time || one_time_loop)

row = Array.new
row.push(startI.strftime("%I:%M%p") + " - " + endI.strftime("%I:%M%p"))


#WE CAN CHOOSE HEADER FOR ONLY THE SQUARE OF THE EVENTS THAT OCCURRED
#OR HEADER FOR ALL ROSTER SQUARES OF STUDENT

#in each loop, we need to make a row of data for the specific
#interval we are dealing with (startI, endI)
  stud_squares.each do |pressed|
    
    
    #FREQUENCY CODE
    if(pressed.tracking_type == 2)
      
    row.push(eventsArray.count { |x| x.behavior_square_id == pressed.id && 
                    (startI <= x.square_press_time &&  x.square_press_time<endI||
                    x.square_press_time <= startI && startI < x.duration_end_time)})
    
    end
    
    
    #INTERVAL CODE
    if(pressed.tracking_type == 3)
      
      y = eventsArray.count { |x| x.behavior_square_id == pressed.id && 
                    (startI <= x.square_press_time &&  x.square_press_time<endI||
                    x.square_press_time <= startI && startI < x.duration_end_time)}
                                          
      if(y > 0)
         
         row.push("X")
      
      else
      
      row.push(" ")
      
      end
    
    end
    
    
    #DURATION CODE
    if(pressed.tracking_type == 1)
      
    z = eventsArray.count { |x| x.behavior_square_id == pressed.id && 
                    (startI <= x.square_press_time &&  x.square_press_time<endI||
                    x.square_press_time <= startI && startI < x.duration_end_time)}
      if(z > 0)
         
         row.push("D")
      
      else
      
      row.push(" ")
      
      end
    
    end
    
  end

  rows.push(row)
  one_time_loop = false
  startI = startI + stud_interval*60
  endI = endI + stud_interval*60
  
end

#new header is array of screen names for each type of square pressed in sesh
newHeader = Array.new

stud_squares.each do |v|
newHeader.push(v.screen_name)
end

newHeader.insert(0, "Time")

table = Array.new {Array.new}
table.push(newHeader)

#push the rows onto our Array of arrays
rows.each do |r|
table.push(r)
end

pdf.move_up 20
pdf.text "All Behaviors Exhibited during Session", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10

pdf.table table, :header => true, 
  :column_widths => { 0 => 125, 1..table.count-1 => 38},
  :row_colors => ["d2e3ed", "FFFFFF"], :position => :center
  
                       # -------DURATION NOTES TABLE---------#

#this is all the durations Squares that were pushed during sesh
durSquares = Array.new

#header is all the SQUARES that happened in the event
header.each do |h|

if(h.tracking_type == 1)
 durSquares.push(h)  
  
end
end

durRows = Array.new {Array.new}

durSquares.each do |d|
r = Array.new
#find all events with the same duration square pressed
r = eventsOccurred.find_all { |x| x.behavior_square_id  == d.id }
#sort them by press time
r.sort! { |a,b| a.square_press_time   <=> b.square_press_time}
durRows.push(r)

end

#now sort the rows (each row is a collection of events that are of the same square id)
#and sort them by the press time of the start time of the FIRST element of array
durRows.sort! { |a,b| a.first.square_press_time   <=> b.first.square_press_time}
header2 = ["Behaviors", "Start Time", "End Time", "Duration"]

table2 = Array.new {Array.new}
table2.push(header2)

durRows.each do |collection|
collection.each do |dEvent|
table2.push([Square.find(dEvent.behavior_square_id ).screen_name.to_s, 
              dEvent.square_press_time.strftime("%I:%M%p"),
              dEvent.duration_end_time.strftime("%I:%M%p"),
              TimeDifference.between(dEvent.square_press_time, 
                            dEvent.duration_end_time).in_minutes.to_s + " min"])  
  
end
end


pdf.move_down 50
pdf.text "Duration Behaviors Exhibited during Session", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10
pdf.table table2, :header => true, 
  :column_widths => { 0 => 100, 1 => 75, 2 => 75, 3 => 75, 4=> 75},
  :row_colors => ["d2e3ed", "FFFFFF"], :position => :center
  
                       # -------Notes Table---------#                      

notesTakenMap = SessionNote.where(session_id: session.id)
notesTaken = Array.new

notesTakenMap.each do |m|
notesTaken.push(m)
end

notesTaken.sort!{ |a,b| a.created_at   <=> b.created_at}

notesTable = Array.new {Array.new}
notesTable.push(["Time", "Note"])

notesTaken.each do |noteOb|
noteRow = Array.new
noteRow.push((noteOb.created_at).strftime("%I:%M%p"))
noteRow.push(noteOb.note)
notesTable.push(noteRow)
end

pdf.move_down 50
pdf.text "Notes taken during Session", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10
pdf.table notesTable, :header => true, 
  :column_widths => { 0 => 150, 1 => 300},
  :row_colors => ["d2e3ed", "FFFFFF"], :position => :center               
                      
                      
                      
                      
                       # -------SESSION KEY---------#
table3 = Array.new {Array.new}
rows3 = Array.new{Array.new}

#CAN PUT HEADER OR STUD_SQUARES
stud_squares.each do |s|
keyRow = Array.new
keyRow.push(s.screen_name.to_s)
keyRow.push(" = ")
keyRow.push(s.description.to_s)

if(s.tracking_type == 1)
  keyRow.push("Duration")
else 
  if(s.tracking_type == 2)
  keyRow.push("Frequency")
  else 
    if(s.tracking_type == 3)
      keyRow.push("Interval")
    end
  end
end

rows3.push(keyRow)
end

rows3.each do |r2|
table3.push(r2)  
end

#will get error if there the rows3 array is empty because that means
#our array of arrays is empty and we have nothing to display
if(rows3.count > 0)
pdf.move_down 50
pdf.text "Session Key", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10
pdf.table table3, :header => true, :cell_style => { :border_color => "FFFFFF" },
 :column_widths => { 0 => 40, 1 => 25, 2 => 200, 3 => 100},:position => :left
end




# Change by Nate V. - Switched from file download to page display of pdf file
# To revert back to downloading a file, remove "disposition: 'inline'"
send_data pdf.render, :filename => "Report1.pdf", :type =>
 "application/pdf", disposition: 'inline'

end

def csv1
    # Grabs the latest session's collection of Session Events
    session = Session.last
    eventsOccurred = SessionEvent.where(session_id: session.id)
    


    # Array used to find a square's square type
    square_types = ["null", "Duration", "Frequency", "Interval"]
    
    # Uses the csv renderer to create a csv string to be updated with the 
    # requisite values
    csv_string = CSV.generate do |csv|
        csv << %w(num square square_type press_time end_time)
        eventsOccurred.each do |item|
            # Specify the square for each given event
            eventSquare = Square.where(id: item.behavior_square_id)
            # Find the given square's screen name and square type
            scrnName = eventSquare.screen_name
            squareType = square_types[eventSquare.tracking_type]
            # Update the csv_string
            csv << [item.id,  scrnName, squareType, 
                item.square_press_time, item.duration_end_time]
        end
    end
    # Renders the csv file
    respond_to do |format|
        format.csv { render :csv => csv_string, :filename => "Report1.csv" }
    end
end


end