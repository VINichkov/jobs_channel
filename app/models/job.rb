# frozen_string_literal: true
class Job < ApplicationRecord

  enum job_type: { full_time: 0, part_time: 1, casual: 2, permanent: 3 }
  enum remote: { no: false, yes: true }
  include AASM

  validates :title, presence: { message: :title_empty }
  validates :location, presence: { message: :location_empty }
  validates :description, length: { minimum: 100, message: :description_is_short }

  aasm do # default column: aasm_state
    state :new, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: :new, to: :approved
    end

    event :reject do
      transitions from: :new, to: :rejected
    end

    event :to_new do
      transitions from: :approved, to: :new
    end
  end

  def approve;  end

  def to_new;  end

  def reject; end

  def to_hash
    {title: title,
     company_name: company_name,
     remote: remote,
     location: location,
     description: description,
     salary_min: salary_min,
     salary_max: salary_max,
     job_type: job_type,
     contact: contact}
  end

  def to_telegram
    tag_remote = remote=='no' ? I18n.t('show.job.remote') : Addition.to_hashtag(I18n.t('show.job.remote'))
    text = ''
    text += "<b>#{title}</b>\n"
    text += "<b>#{I18n.t('show.job.company')}:</b> #{company_name}\n"
    text += "<b>#{I18n.t('show.job.location')}:</b> #{Addition.to_hashtag(location)}\n"
    text += "<b>#{tag_remote}:</b> #{I18n.t("job.remote.#{remote}")}\n"
    text += "<b>#{I18n.t('show.job.job_type')}:</b> #{Addition.to_hashtag(I18n.t("job.job_type.#{job_type}"))}\n"
    text += "<b>#{I18n.t('show.job.salary')}:</b> #{salary(true)}\n" if salary
    text += "<b>#{I18n.t('show.job.description')}</b>\n"
    text += "#{description}\n"
    text += "<b>#{I18n.t('show.job.contact')}:</b> #{contact}"
    text
  end

  def salary(tag = false)
    local_tag = tag ? 'salary' : 'salary_tag'
    min = salary_min || 0
    max = salary_max || 0
    return I18n.t(local_tag, salary: min) if min != 0 and max == 0
    return I18n.t(local_tag, salary: max) if min == 0 and max != 0
    return nil if min == 0 and max == 0
    "#{I18n.t(local_tag, salary: min)} - #{I18n.t(local_tag, salary: max)}"
  end

end
