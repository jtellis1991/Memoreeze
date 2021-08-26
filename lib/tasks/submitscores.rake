desc "Hydrate the database with some dummy data to look at so that developing is easier"
task({ :submit_scores => :environment}) do
  #This task runs at the end of every day (based on time zone).
  #If DeckAccount.is_todays_study_complete == true, then Grades.score increases by Assignment.points_up unless Grades.score == Grades.points_possible
  #If DeckAccount.is_todays_study_copmlete !- true, then Grades.score decreases by Assignment.points_down unless Grades.score == 0
  #Send back Grades.score
  
  starting = Time.now

  instructors = User.all.where(roles: "Instructor")
  instructors.each do |instructor|
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
        {"lis_outcome_service_url"=>"https://canvas.instructure.com/api/lti/v1/tools/529270/grade_passback", "lis_result_sourcedid"=> "529270-2809753-24268784-30184579-3ee00df884227df1db3938dd3a71a4d0acd9e48d"})
        # add extension
        @tp.extend IMS::LTI::Extensions::OutcomeData::ToolProvider

        unless @tp.outcome_service?
          puts "This tool wasn't launched as an outcome service"
        end

        # res = @tp.post_extended_replace_result!(score: params[:score])
        res = @tp.post_extended_replace_result!(score: 0.7)

        if res.success?
          puts 'Score Submitted'
        else
          puts 'Error during score submission'
        end
          
      end
    end
  end

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create submit scores."
end