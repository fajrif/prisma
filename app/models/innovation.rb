class Innovation < ApplicationRecord
  extend Mobility
  translates :title, :description

  default_scope { order(id: :asc) }

  validates_presence_of :title, :description, :icon

  def name
    self.title
  end
end
