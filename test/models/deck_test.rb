# == Schema Information
#
# Table name: decks
#
#  id            :bigint           not null, primary key
#  name          :string
#  user_id       :integer
#  assignment_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class DeckTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
