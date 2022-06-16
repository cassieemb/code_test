class Tag < ApplicationRecord
  belongs_to :ticket

  def self.return_most_used_tag
    Tag.all.group(:tag_name).count(:tag_name).max
  end

end
