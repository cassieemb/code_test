class Tag < ApplicationRecord
  belongs_to :ticket

  # group tags by tag name, check for value with highest count and return key value pair
  def self.return_most_used_tag
    grouped_tags = Tag.all.group(:tag_name).count(:tag_name)
    grouped_tags.max_by{|k, v| v}
  end

end
