class Alternation < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :name, :alternation_type, :coding_frames_text, :description, :id, :language_id, :complexity

  belongs_to :language
  has_many :alternation_values
  has_many :verbs,    :through => :alternation_values
  has_many :examples, :through => :alternation_values # I wonder if this will work

  def to_s
    name
  end
  
  # return true iff the alternation_type is "coded" or "Coded"
  def coded?
    alternation_type && alternation_type.casecmp("coded") == 0
  end
  
  # return "y" if alternation_type is "coded", 'n' if it isn't
  # returns nil if alternation_type is nil
  def coded_y_n
    if alternation_type
      self.coded? ? 'y' : 'n'
    end 
  end
  
  # count verbs that occur *regularly* in this alternation
  def count_verbs
    @regular_verb_count ||= self.alternation_values
    .where(alternation_occurs: 'Regularly').reduce(0) do |sum, av|
      if av.verb then sum + 1 else sum end
    end
  end
  
  # get examples for Regular values of this alt'n
  def get_examples
    avs = self.alternation_values.includes(:examples).where(alternation_occurs: 'Regularly')
    avs.map { |av| av.examples }.flatten
  end
  
  
end
