# == Schema Information
#
# Table name: grades
#
#  id              :bigint           not null, primary key
#  score           :integer
#  points_possible :integer
#  enrollment_id   :integer
#  assignment_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class GradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
