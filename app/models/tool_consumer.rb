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
class ToolConsumer < ApplicationRecord
  has_many :users, class_name: "User", foreign_key: :tool_consumer_id, dependent: :destroy })
  has_many :courses, class_name: "Course", foreign_key: :tool_consumer_id, dependent: :destroy })

end
