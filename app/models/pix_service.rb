class PixService < ApplicationRecord
	extend Mobility
  translates :title, :description

	default_scope { order(id: :asc) }

  validates_presence_of :title, :description
	validates_uniqueness_of :title

  def name
    self.title
  end
end
