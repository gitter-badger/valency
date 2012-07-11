class CodingFrame < ActiveRecord::Base
  belongs_to :language
  has_many :verbs
  has_many :alternation_values, inverse_of: :derived_coding_frame

  has_many :coding_frame_index_numbers
  has_many :coding_sets,    :through => :coding_frame_index_numbers
  has_many :argument_types, :through => :coding_frame_index_numbers

  has_many :coding_frame_examples
  has_many :examples,    :through => :coding_frame_examples

  has_many :verb_coding_frame_microroles
  has_many :microroles,  :through => :verb_coding_frame_microroles
  
  has_many :microrole_index_numbers
  has_many :indexed_microroles, through: :microrole_index_numbers, source: :microrole_id

  attr_accessible :coding_frame_schema, :comment, :description, :id, :language_id
end
