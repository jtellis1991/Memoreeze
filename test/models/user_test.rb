# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  roles            :string
#  tool_consumer_id :integer
#  tc_user_id       :string
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
