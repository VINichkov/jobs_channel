# frozen_string_literal: true

class Job < ApplicationRecord
  enum job_type: { 'Full time': 0, 'Part time': 1, 'Casual/Temporary': 2, 'Permanent': 3 }
  enum remote: { 'No': false, 'Yes': true }
  include AASM

  validates :title, :location, presence: true
  validates :description, length: { minimum: 100 }

  aasm do # default column: aasm_state
    state :new, initial: true
    state :approved
    state :rejected

    event :approv do
      transitions from: :new, to: :approved
    end

    event :reject do
      transitions from: :new, to: :rejected
    end
  end

  def approv
    save
  end

  def reject; end
end
