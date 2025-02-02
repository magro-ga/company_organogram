class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :manager, class_name: 'Employee', optional: true
  has_many :subordinates, class_name: 'Employee', foreign_key: 'manager_id'

  validates :name, presence: true
  validates :email, presence: true
  validate :manager_cannot_create_hierarchy_loop

  private

  def manager_cannot_create_hierarchy_loop
    return if manager.nil?

    if creates_hierarchy_loop?(self)
      errors.add(:manager, "não pode criar um loop na hierarquia")
    end
  end

  def creates_hierarchy_loop?(employee)
    current_manager = manager
    while current_manager
      return true if current_manager == employee
      current_manager = current_manager.manager
    end
    false
  end
end