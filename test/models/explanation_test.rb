# == Schema Information
#
# Table name: explanations
#
#  id          :bigint           not null, primary key
#  explanation :text
#  target_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class ExplanationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
