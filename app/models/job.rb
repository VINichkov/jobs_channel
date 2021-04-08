# frozen_string_literal: true

class Job < ApplicationRecord
  include AASM

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
