class Search < ActiveRecord::Base
  attr_accessible :keywords, :id_worker, :id_worker_merx, :min_effectivity, :max_effectivity, :date_from, :date_to, :name_tokens, :stanowisko, :obszar, :jedn_organizacyjna
  has_many :workers

def workers
  @workers ||= find_products
end

def name_tokens=(ids)
end

private

def find_products
  @array = keywords.split(",").map(&:to_i)
  if @array.size > 0  
     val = { :id => @array}
    else
     val = conditions
  end
  Worker.find(:all, :conditions => val, :include => [:effectivenes], :joins => ["left join realizacja_norm rn on rn.rn_id_worker_merx =  workers.id_worker_merx"]).uniq
end


def id_worker_conditions
  ["workers.id_worker in (?)", id_worker] unless id_worker.blank?
end
def keywords_conditions 

end
def id_worker_merx_conditions
  ["workers.id_worker_merx in (?)", id_worker_merx] unless id_worker_merx.blank?
end
def stanowisko_conditions
  ["workers.stanowisko = ?", stanowisko] unless stanowisko.blank?
end
def jedn_organizacyjna_conditions
  ["workers.jednostka_organizacyjna = ?", jedn_organizacyjna] unless jedn_organizacyjna.blank?
end
def jedn_organizacyjna_conditions
  ["workers.obszar = ?", obszar] unless obszar.blank?
end

def minimum_effectivity_conditions
  ["effectivenes.effectivity >= ?", min_effectivity] unless min_effectivity.blank?
end

def maximum_effectivity_conditions
  ["effectivenes.effectivity <= ?", max_effectivity] unless max_effectivity.blank?
end

def date_from_conditions
  ["rn.rn_data >= ?", date_from] unless date_from.blank?
end

def date_to_conditions
  ["rn.rn_data <= ?", date_to] unless date_to.blank?
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
