# == Schema Information
#
# Table name: courses
#
#  id               :bigint           not null, primary key
#  tool_consumer_id :integer
#  user_id          :integer
#  context_id       :string
#  context_title    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
