# == Schema Information
#
# Table name: assignments
#
#  id               :bigint           not null, primary key
#  course_id        :integer
#  resource_link_id :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
