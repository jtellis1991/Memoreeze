# == Schema Information
#
# Table name: targets
#
#  id          :bigint           not null, primary key
#  target      :string
#  explanation :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class TargetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
