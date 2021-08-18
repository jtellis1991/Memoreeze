# == Schema Information
#
# Table name: tool_consumers
#
#  id             :bigint           not null, primary key
#  guid           :string
#  name           :string
#  product_family :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class ToolConsumerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
