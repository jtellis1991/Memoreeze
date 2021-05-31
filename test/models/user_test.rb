# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  role             :integer
#  tool_consumer_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
