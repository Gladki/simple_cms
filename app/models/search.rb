class Search < ActiveRecord::Base
  attr_accessible :keywords, :id_worker, :id_worker_merx, :min_effectivity, :max_effectivity, :date_from, :date_to

def workers
  @workers ||= find_products
end

private

def find_products
  Worker.find(:all,  :conditions => conditions ,:include => [:effectivenes], :joins => [:effectivenes])
end

def keywords_conditions
  ["workers.first_name like ?", "%#{keywords}%"] unless keywords.blank?
  ["workers.last_name like ? ", "%#{keywords}%"] unless keywords.blank?
  
end
def id_worker_conditions
  ["workers.id_worker in (?)", id_worker] unless id_worker.blank?
end

def id_worker_merx_conditions
  ["workers.id_worker_merx in (?)", id_worker_merx] unless id_worker_merx.blank?
end

def minimum_effectivity_conditions
  ["effectivenes.effectivity >= ?", min_effectivity] unless min_effectivity.blank?
end

def maximum_effectivity_conditions
  ["effectivenes.effectivity <= ?", max_effectivity] unless max_effectivity.blank?
end

def date_from_conditions
  ["effectivenes.created_at >= ?", date_from] unless date_from.blank?
end

def date_to_conditions
  ["effectivenes.created_at <= ?", date_to] unless date_to.blank?
end



def conditions
  [conditions_clauses.join(' AND '), *conditions_options]
end

def conditions_clauses
  conditions_parts.map { |condition| condition.first }
end

def conditions_options
  conditions_parts.map { |condition| condition[1..-1] }.flatten
end

def conditions_parts
  private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
end


end
