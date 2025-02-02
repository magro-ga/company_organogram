class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :manager, class_name: "Employee", optional: true
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
