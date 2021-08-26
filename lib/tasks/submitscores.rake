desc "Hydrate the database with some dummy data to look at so that developing is easier"
task({ :submit_scores => :environment}) do
  #This task runs at the end of every day (based on time zone).
  #If DeckAccount.is_todays_study_complete == true, then Grades.score increases by Assignment.points_up unless Grades.score == Grades.points_possible
  #If DeckAccount.is_todays_study_copmlete !- ture, then Grades.score decreases by Assignment.points_down unless Grades.score == 0
  #Send back Grades.score
  
  starting = Time.now

  instructors = User.all.where(roles: "Instructor")
  instructors.each do |instructor|
    p instructor.name
  end

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create submit scores."
end