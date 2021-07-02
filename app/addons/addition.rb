# frozen_string_literal: true

class Addition
  def self.to_hashtag(str)
    "##{str.strip.gsub(/\W/, '_').camelize}" if str.present?
  end

  def self.remote_frequent_keywords(keys)
    keys.gsub(/((\W|^|\s)(of|on|in|from|i|you|he|she|it|is|are|r|s|we|they|m|who|am|me|whom|her|him|us|them|my|mine|his|hers|your|yours|our|ours|their|theirs|whose|its|that|which|where|why|a|the|as|an|over|under|to|whith|whithout|by|at|into|onto|work|job|looking|Responsibilities|responsibilities|Aug|Jul|Projects|Dec|Mrs|Mr|experience)(\s|$|\W))/,' ')
  end
  
end
