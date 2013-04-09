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

  def title(page_title)
    content_for(:title) { page_title }
  end

  def imie_nazwisko_worker(worker_id)

    @imie = Worker.where("id = ?", worker_id).pluck(:first_name) 
    @nazwisko = Worker.where("id = ?", worker_id).pluck(:last_name)
    return @imie + @nazwisko
  end

  def maximum_effectivity(worker_id)
    @maximum_effectivity = Effectivenes.maximum(:effectivity, :conditions => ["worker_id = ?", worker_id])
    return @maximum_effectivity.to_f
  end

  def minimum_effectivity(worker_id)
    @minimum_effectivity = Effectivenes.minimum(:effectivity, :conditions => ["worker_id = ?", worker_id])
    return @minimum_effectivity.to_f
  end 

  # def effectivity_min(worker_id)
  #   @effectivity_min = Effectivenes.where("effectivenes.worker_id = ?", worker_id).limit(1).pluck(:effectivity_min)
  #   return @effectivity_min

  # end 
  #  def effectivity_max(worker_id)
  #   @effectivity_max = Effectivenes.where("effectivenes.worker_id = ?", worker_id).limit(1).pluck("effectivity_max")
  #   @effectivity_max
  # end  
  def cel_min(worker_id)
    if Cele.all.include?(worker_id) == false
    @cel_min = Cele.where("ce_worker_id = ?", worker_id).order('id desc').limit(1).pluck(:ce_minimum)
    return @cel_min
    else
      @cel_min = 0
    end


  end  
   def cel_max(worker_id)
    if Cele.all.include?(worker_id) == false
    @cel_max = Cele.where("ce_worker_id = ?", worker_id).order('id desc').limit(1).pluck(:ce_maximum)
    return @cel_max
    else
      @cel_max = 0
    end
  end  

  def predkosc_po_kodzie(predkosc_kod)
    @predkosc = Predkosci.where("pr_kod = ?" , predkosc_kod).limit(1).pluck(:pr_predkosc_km)
    return @predkosc
  end

  def dodatek_po_kodzie(dodatek_kod)
    @dodatek = Dodatki.where("do_kod = ?" , dodatek_kod).limit(1).pluck(:do_czas_zakr)
    return @dodatek
  end 
  
  def dodatek_start_po_kodzie(dodatek_kod_start)
    @dodatek_start = Dodatki.where("do_kod = ?" , dodatek_kod_start).limit(1).pluck(:do_czas_start_stop)
    return @dodatek_start
  end

 def last_update_effectivity(worker_id)
    @last_update_effectivity = Effectivenes.maximum(:created_at, :conditions => ["worker_id = ?", worker_id])
    return @last_update_effectivity
  end


    def count_effectivity(worker_id)
      Effectivenes.count(:conditions => ["worker_id = ?", worker_id])
    end


  

  
end
