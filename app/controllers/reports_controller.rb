class ReportsController < ApplicationController

def report1
#Eventually going to refactor this so this type of report is in its own class
#Right? That way we can have methods for each table like last years's class

pdf = Prawn::Document.new
pdf.font "Helvetica"

# Defining the grid (this might not be needed in the long run)
# See http://prawn.majesticseacreature.com/manual.pdf
pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 


                      # -------Session Data---------#
#for now, just grab the first seeded session
session = Session.find(1)
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


                      # -------Unused Stuff right here---------#
          # ----Use this if you want to make header info a table instead----#
#row1 = Array.new
#row1.push "Student Name:" + student.full_name
#row1.push "Date: #{session.start_time.to_date}"

#row2 = Array.new
#row2.push "Teacher Name: " + teacher.full_name
#row2.push "Time: " + session.start_time.strftime("%I:%M%p") + " - " +
                      #session.end_time.strftime("%I:%M%p")
                      
                      
#name_and_date = Array.new {Array.new}
#name_and_date.push row1
#name_and_date.push row2

#pdf.table name_and_date, :header => true, :cell_style => { :border_color => "FFFFFF" },
  #:column_widths => { 0 => 350, 1 => 190}, :position => :left

                      # -------ENTIRE SUMMARY TABLE---------#

#header is the first row for our table, will have this format:
#[TIME, BehaviorSquare1, BS2, BS3, ...]
header = Array.new
rows = Array.new{Array.new}

#for each square pressed in the session
eventsOccurred.each do |event|
 
 #add the SQUARE object to the header array
 if header.exclude? Square.find(event.behavior_square_id)

   header.push(Square.find(event.behavior_square_id ))
   
 end 
  
end

#SORT the header array by square TYPE
#Will sort by duration, then frequency, then interval...Can we change this?
header.sort! { |a,b| a.tracking_type  <=> b.tracking_type}

#Let's start doing some actual data rows for our table
#Right now, just assume a 15 minute interval

startI = session.start_time

#adds 15 minutes to the start time
endI = session.start_time + 15*60

eventsArray = Array.new

#make it an array instead of map, 
#was getting weird errors with truth statements when using the map
eventsOccurred.each do |event|
        eventsArray.push(event)
      end


#THE MONEY $$$
while endI <= session.end_time

row = Array.new
row.push(startI.strftime("%I:%M%p") + " - " + endI.strftime("%I:%M%p"))

#WE'LL HAVE TO DITCH THIS SOON. THIS DOES AN INTERVAL LIKE THIS [START,FINISH]
#WE DOUBLE COUNT WHEN START OR END OF AN EVENT IS EQUAL TO A START OR END OF AN INTERVAL
#I know how to fix this, but I will do this later.
range = startI.to_i..endI.to_i


#in each loop, we need to make a row of data for the specific
#interval we are dealing with (startI, endI)
  header.each do |pressed|
    
    
    #FREQUENCY CODE
    if(pressed.tracking_type == 2)
      
    row.push(eventsArray.count { |x| x.behavior_square_id == pressed.id && 
                                          (range === x.square_press_time.to_i ||
                    x.square_press_time <= startI && startI <= x.duration_end_time)})
    
    end
    
    
    #INTERVAL CODE
    if(pressed.tracking_type == 3)
      
      y = eventsArray.count { |x| x.behavior_square_id == pressed.id && 
                                          (range === x.square_press_time.to_i ||
                    x.square_press_time <= startI && startI <= x.duration_end_time)}
                                          
      if(y > 0)
         
         row.push("X")
      
      else
      
      row.push(" ")
      
      end
    
    end
    
    
    #DURATION CODE
    if(pressed.tracking_type == 1)
      
    z = eventsArray.count { |x| x.behavior_square_id == pressed.id && 
                                          (range === x.square_press_time.to_i ||
                    x.square_press_time <= startI && startI <= x.duration_end_time)}
      if(z > 0)
         
         row.push("D")
      
      else
      
      row.push(" ")
      
      end
    
    end
    
  end

  rows.push(row)
  startI = startI + 15*60
  endI = endI + 15*60
  
end

#new header is array of screen names for each type of square pressed in sesh
newHeader = Array.new

header.each do |v|
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
pdf.text "All Behaviors Exhibeted during Session", :style => :bold
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
                            dEvent.duration_end_time).in_minutes.to_s])  
  
end
end


pdf.move_down 50
pdf.text "Duration Behaviors Exhibeted during Session", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10
pdf.table table2, :header => true, 
  :column_widths => { 0 => 100, 1 => 75, 2 => 75, 3 => 75, 4=> 75},
  :row_colors => ["d2e3ed", "FFFFFF"], :position => :center
  
                       # -------Notes Table---------#                      

notesTaken = SessionNote.where(session_id: session.id)
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

header.each do |s|
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

pdf.move_down 50
pdf.text "Session Key", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10
pdf.table table3, :header => true, :cell_style => { :border_color => "FFFFFF" },
  :column_widths => { 0 => 40, 1 => 25, 2 => 200, 3 => 100},:position => :left




# Change by Nate V. - Switched from file download to page display of pdf file
# To revert back to downloading a file, remove "disposition: 'inline'"
send_data pdf.render, :filename => "Report1.pdf", :type =>
 "application/pdf", disposition: 'inline'

end

end