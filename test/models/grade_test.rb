# == Schema Information
#
# Table name: grades
#
#  id            :bigint           not null, primary key
#  deck_id       :integer
#  score         :float
#  enrollment_id :integer
#  assignment_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class GradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
