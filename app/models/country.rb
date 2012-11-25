class Country < ActiveRecord::Base
  attr_accessible :iso, :name

  has_many :states

  def self.all_states_included
    includes(:states)
  end

  def self.all_states_and_counts_included
    includes(:states)
    .select('countries.*, count(states.id) as count_states')
    .joins('LEFT OUTER JOIN states ON states.country_id = countries.id')
    .group('countries.id')
  end
end
