desc "Hydrate the database with some dummy data to look at so that developing is easier"
task({ :submit_scores => :environment}) do
  #This task runs at the end of every day (based on time zone).
  #If DeckAccount.is_todays_study_complete == true, then Grades.score increases by Assignment.points_up unless Grades.score == Grades.points_possible
  #If DeckAccount.is_todays_study_copmlete !- true, then Grades.score decreases by Assignment.points_down unless Grades.score == 0
  #Reset the DecKAccount.is_todays_study_complete to false
  #Send back Grades.score/Grades.points_possible to the Canvas Assignment
  
  starting = Time.now

  instructors = User.all.where(roles: "Instructor")
  instructors.each do |instructor|
    if instructor.review_setting.last_submission.to_date < Time.now.in_time_zone(instructor.review_setting.time_zone).to_date
      assignments = instructor.assignments
      assignments.each do |assignment|
        grades = assignment.grades
        grades.each do |grade|
          if grade.deck_account.is_todays_study_complete?
            grade.update(score: grade.score + assignment.points_up) unless grade.score == grade.points_possible
            p grade.score
          else
            grade.update(score: grade.score - assignment.points_down) unless grade.score == 0
            p grade.score
          end
          grade.deck_account.update(is_todays_study_complete: false)

          ## SUMBMIT SCORE BACK TO CANVAS
          @tp = IMS::LTI::ToolProvider.new(:quizkey,
          Rails.configuration.lti_settings[:quizkey],
          {"lis_outcome_service_url"=>grade.lis_outcome_service_url, "lis_result_sourcedid"=>grade.lis_result_sourcedid})
          # add extension
          @tp.extend IMS::LTI::Extensions::OutcomeData::ToolProvider

          unless @tp.outcome_service?
            puts "This tool wasn't launched as an outcome service"
          end

          # res = @tp.post_extended_replace_result!(score: params[:score])
          res = @tp.post_extended_replace_result!(score: grade.score/grade.points_possible.to_f)

          if res.success?
            puts 'Score Submitted'
          else
            puts 'Error during score submission'
          end
            
        end
      end
      instructor.review_setting.update(last_submission: Time.now.in_time_zone(instructor.review_setting.time_zone).to_date)
    else 
      p instructor.name + "'s scores were already submitted today"
    end
  end
  

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to submit scores."
end