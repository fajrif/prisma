class Benefit < ApplicationRecord
	extend Mobility
  translates :content

	belongs_to :service

	validates_presence_of :content

end
