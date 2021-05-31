# == Schema Information
#
# Table name: review_settings
#
#  id              :bigint           not null, primary key
#  user_id         :integer
#  reviews_per_day :string
#  new_per_day     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class ReviewSetting < ApplicationRecord
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })

end
