module ApplicationHelper
  
  def status_tag(boolean, options={})
    options[:true]        ||= ''
    options[:true_class]  ||= 'status true'
    options[:false]       ||= ''
    options[:false_class] ||= 'status false'

    if boolean
      content_tag(:span, options[:true], :class => options[:true_class])
    else
      content_tag(:span, options[:false], :class => options[:false_class])
    end
  end

  def error_messages_for( object )
  
    render(:partial => 'shared/error_messages', :locals => {:object => object})
    
  end

  def render_worker_to_table ( id )
    @worker = Worker.find(:all,  :include => [:effectivenes], 
    :joins => "left join effectivenes ef on ef.id = workers.id", 
    :conditions => ['workers.id in (?)', id])
    effectivity =  Effectivene.find(:all , :conditions => ['effectivenes.id in (?)', id])
    result = ["<tr>"]
    @worker.each do |f|
      result.append "<td>"
      result.append f.id_worker
      result.append "</td><td>"
      result.append f.id_worker_merx
      result.append "</td><td>"
      result.append f.first_name
      result.append "</td><td>"
      result.append f.last_name
      result.append "</td><td>"
        f.effectivenes.each do |ef| 
          result.append ef.effectivity
          result.append "%</td><td>"
          result.append ef.effectivity_max
          result.append "%</td><td>"
          result.append ef.effectivity_min
          result.append "%</td><td "
          efektywnosc = ((ef.effectivity - ef.effectivity_min).to_f /
          (ef.effectivity_max - ef.effectivity_min).to_f)*100 
          if efektywnosc > 0 
          result.append '''class="ok"'''
          result.append ">"
          result.append efektywnosc
          result << "%" 
          else 
          result.append '''class="bad"'''
          result << ">"
          result.append efektywnosc
          result << "%"
          end 
          result.append "</td><td>"
          result << '''<a href="wyszukaj/''' 
          result << f.id
          result << '''"><input type="submit" value="szczegoly"></input></a>'''

          result.append "</td>"
          end
        result.append "</tr>"

      end
    return result


    
  end

  def count_effectivity_by_id ( id )
    effectivity =  Effectivene.find(:all , :conditions => ['effectivenes.id in (?)', id])
    @result = []    
    effectivity.each do |e|
      @result << ((e.effectivity - e.effectivity_min).to_f / (e.effectivity_max - e.effectivity_min).to_f)*100
      end 

    return @result
  end

  
end
