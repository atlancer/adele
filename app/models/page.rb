class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title,
            presence: true
#   todo add nested set

end

# Максимальная длина не должна превышать
# 70 символов, а минимальную рекомендуется делать не менее 50 знаков
