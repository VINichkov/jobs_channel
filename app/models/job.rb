# frozen_string_literal: true
require 'date'

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

  def date_posted
    updated_at.to_date()
  end

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
    text += "<strong>#{title}</strong>\n"
    text += "<strong>#{I18n.t('show.job.company')}:</strong> #{company_name}\n"
    text += "<strong>#{I18n.t('show.job.location')}:</strong> #{Addition.to_hashtag(location)}\n"
    text += "<strong>#{tag_remote}:</strong> #{I18n.t("job.remote.#{remote}")}\n"
    text += "<strong>#{I18n.t('show.job.job_type')}:</strong> #{Addition.to_hashtag(I18n.t("job.job_type.#{job_type}"))}\n"
    text += "<strong>#{I18n.t('show.job.salary')}:</strong> #{salary(true)}\n" if salary
    text += "<strong>#{I18n.t('show.job.description')}</strong>\n"
    text += "#{description_text(400)}...\n"
    text
  end

  def salary(tag = false)
    local_tag = tag ? 'salary_tag' : 'salary'
    min = salary_min || 0
    max = salary_max || 0
    return I18n.t(local_tag, salary: min) if min != 0 and max == 0
    return I18n.t(local_tag, salary: max) if min == 0 and max != 0
    return nil if min == 0 and max == 0
    "#{I18n.t(local_tag, salary: min)} - #{I18n.t(local_tag, salary: max)}"
  end

  def self.search(search_params)
    query = search_params.to_query
    logger.debug("Query:: #{query}")
    params = search_params.to_h
    logger.debug("Params:: #{params.to_s}")
    return self.all if query.blank?
    mode = "ARRAY['phrase', 'plain', 'none']"
    select(:id, :title, :company_name, :remote, :location, :description, :tags, :updated_at,
           :salary_min, :salary_max, :job_type, :contact,
           "user_rank(fts, '#{params[:search_key]}', '#{params[:search_key]}', #{mode}) AS \"rank\"").where(query, params)
  end

  def description_text( truncate=nil)
    #description.gsub(/<strong>|<\/strong>|<span>|<\/span>|<\/div>|<ul>|<\/ul>|<\/li>|<\/p>|<li>|<br>|<div>|<h1>|<h2>|<h3>|<h4>|<b>|<\/h1>|<\/h2>|<\/h3>|<\/h4>|<\/b>|<p>/," ").squish
    if description
      arg = truncate.nil? ?  description : description[0..truncate*2]
      text = HtmlToPlainText.plain_text(arg).squish
      if truncate
        text = text.truncate(truncate, separator: ' ',omission: '')
      end
    end
  end

  def keywords(count_keys = 20, min_length_word = 4)
    if title
      array_keywords = [title] * 10
      array_keywords += [location] * 10
      if description
        desc = HtmlToPlainText.plain_text(description)
        desc = Addition.remote_frequent_keywords(desc)&.squish
        array_keywords += desc&.gsub(/[^[:word:]]/, ' ')&.downcase&.split(' ')
      end
      array_keywords.compact!
      index_hash = {}
      array_keywords.each do |word|
        if word.length > min_length_word
          index_hash[word] ? index_hash[word] += 1 : index_hash[word] = 1
        end
      end
      array_keywords = []
      index_hash.each do |key, value|
        array_keywords << { key => value }
      end
      array_keywords.sort { |x, y| y.values[0] <=> x.values[0] }[0..count_keys - 1].map { |t| t.keys.first }
    end
  end

  def title_text
    if title
      location.present? ? "#{location} | #{title}" : title
    end
  end


end
