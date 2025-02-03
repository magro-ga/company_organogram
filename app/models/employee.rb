class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :manager, class_name: 'Employee', optional: true
  has_many :subordinates, class_name: 'Employee', foreign_key: 'manager_id'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validate :manager_must_be_in_same_company
  validate :no_circular_hierarchy

  private

  def manager_must_be_in_same_company
    return if manager.nil? || manager.company_id == company_id
    errors.add(:manager, "must belong to the same company")
  end

  def no_circular_hierarchy
    return if manager.nil?
    errors.add(:manager, "cannot create a hierarchy loop") if creates_hierarchy_loop?
  end

  def creates_hierarchy_loop?
    current_manager = manager
    while current_manager
      return true if current_manager == self
      current_manager = current_manager.manager
    end
    false
  end
end
