class Search
  include Virtus.model
  include ActiveModel::Model

  JOB_TYPES = { full_time: 0, part_time: 1, casual: 2, permanent: 3, any: 4 }
  REMOTE = { no: false, yes: true, any: 2 }
  DEFAULT_JOB_TYPE = JOB_TYPES[:any]
  DEFAULT_REMOTE = REMOTE[:any]

  attribute :search_key, String, default: ''
  attribute :location, String, default: ''
  attribute :job_type, Integer, default: DEFAULT_JOB_TYPE
  attribute :remote, Integer, default: DEFAULT_REMOTE
  attribute :salary, Integer, default: nil
  def self.job_types
    JOB_TYPES
  end

  def self.remotes
    REMOTE
  end

  def to_h
    hash = {}
    hash[:search_key] = prepare_keys if search_key.present?
    hash[:location] = "%#{location}%" if location.present?
    hash[:remote] = remote if remote != DEFAULT_REMOTE
    hash[:job_type] = job_type if job_type != DEFAULT_JOB_TYPE
    hash[:salary] = salary if salary.present? and salary > 0
    hash
  end

  def to_query
    prepare_keys
    query = []
    query.push('remote = :remote') if remote != DEFAULT_REMOTE
    query.push('job_type = :job_type') if job_type != DEFAULT_JOB_TYPE
    query.push('(salary_min>=:salary or salary_max >= :salary)') if salary.present? and salary > 0
    query.push('location like :location') if location.present?
    query.push('fts @@ to_tsquery(\'english\',:search_key)') if prepare_keys.present?
    query.push("aasm_state = 'approved'") if query.present?
    query.join(' and ')
  end

  private

  def prepare_keys
    keys = search_key.delete("<>{}#@!,:*&()'`\"’|")
    if keys.present?
      Addition.remote_frequent_keywords(keys).split(" ").map{|t| t=t+":*"}.join("|")
    end
  end

end