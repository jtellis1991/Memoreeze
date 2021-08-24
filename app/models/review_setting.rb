# == Schema Information
#
# Table name: review_settings
#
#  id              :bigint           not null, primary key
#  user_id         :integer
#  reviews_per_day :string           default("10")
#  new_per_day     :integer          default(10)
#  time_zone       :string           default("Central Time (US & Canada)")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class ReviewSetting < ApplicationRecord
  belongs_to :user, required: false, class_name: "User", foreign_key: :user_id

end
