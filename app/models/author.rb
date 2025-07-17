class Author < ApplicationRecord

	validates_presence_of :name, :title, :company_name, :phone, :email

	has_many :reports

end
