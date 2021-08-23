desc "Hydrate the database with some dummy data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  #run this task after launching course, assignment as Instructor from Canvas. This will create students for your course/assignment, create decks for you, and populate decks with targets/cards.
  
  starting = Time.now

  Deck.delete_all
  Card.delete_all
  Target.delete_all

  people = Array.new(10) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
    }
  end

  people << { first_name: "Alice", last_name: "Smith" }
  people << { first_name: "Bob", last_name: "Smith" }
  people << { first_name: "Carol", last_name: "Smith" }
  people << { first_name: "Doug", last_name: "Smith" }

  people.each do |person|

    user = User.create(
      name: "#{person[:first_name]} #{person[:last_name]}",
      roles: "Learner",
      tool_consumer_id: ToolConsumer.first.id,
      tc_user_id: Faker::Internet.password(min_length: 40, max_length: 40) #=> "EoC9ShWd1hWq4vBgFw"
    )

    #need to set up enrollments here for the students

    p user.errors.full_messages
  end

  instructor = User.first

  rand(15).times do
    deck = instructor.decks.create(
      name: Faker::Dessert.variety,
    )

    p deck.errors.full_messages
  end

  instructor.decks.each do |deck|
    rand(15).times do
      target = Target.create(
        target: Faker::Lorem.word,
        explanation: Faker::Lorem.paragraph(
          sentence_count: 2,
          supplemental: true,
          random_sentences_to_add: 4
        )
      )
      
      deck.cards.create(
        target_id: target.id,
        illustrative_test: Faker::Lorem.question,
        solution: Faker::Lorem.sentence
      )
    end
  end
  

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{Deck.count} decks."
  p "There are now #{Card.count} cards."
  p "There are now #{Target.count} targets."
end