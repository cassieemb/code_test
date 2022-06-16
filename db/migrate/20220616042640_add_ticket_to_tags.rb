class AddTicketToTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :ticket, null: false, foreign_key: true
  end
end
