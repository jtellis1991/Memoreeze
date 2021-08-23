# == Schema Information
#
# Table name: assignments
#
#  id                  :bigint           not null, primary key
#  course_id           :integer
#  user_id             :integer
#  resource_link_id    :string
#  resource_link_title :string
#  deck_id             :integer
#  points_up           :integer          default(1)
#  points_down         :integer          default(1)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
