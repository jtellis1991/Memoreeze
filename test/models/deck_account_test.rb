# == Schema Information
#
# Table name: deck_accounts
#
#  id                       :bigint           not null, primary key
#  user_id                  :integer
#  grade_id                 :integer
#  deck_id                  :integer
#  is_todays_study_complete :boolean          default(FALSE)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require "test_helper"

class DeckAccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
