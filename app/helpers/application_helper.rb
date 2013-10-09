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
  def worker_id_by_merx(id_worker_merx)
    id = Worker.where("id_worker_merx = ?", id_worker_merx).pluck(:id).first
    return id
  end

  def imie_nazwisko_worker_by_merx(worker_id_merx)

    @imie = Worker.where("id_worker_merx = ?", worker_id_merx).pluck(:first_name) 
    @nazwisko = Worker.where("id_worker_merx = ?", worker_id_merx).pluck(:last_name)
    return @imie + @nazwisko
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
  def minimum_effectivity_data(worker_id,data)
    @minimum_effectivity_data = Effectivenes.minimum(:effectivity, :conditions => ["worker_id = ? and ef_data like ?", worker_id,"%#{data}%"])
    return @minimum_effectivity_data.to_f
  end 
  def czas_dostepny_data(worker_id,data)
    @czas_dostepny = Tabelaczasowdostepnych.select("sum(tcd_sum_godz_przep)").where("tcd_id_worker_merx =? and tcd_data like ?", worker_id, data).group("tcd_data").order("tcd_data desc").pluck(:tcd_sum_godz_przep).first
    return @czas_dostepny.to_f.round(2)
  end 

  def cel_min(worker_id)
    if Cele.all.include?(worker_id) == false
    @cel_min = Cele.where("ce_worker_id = ?", worker_id).order('id desc').limit(1).pluck(:ce_minimum)
    return @cel_min
    else
      @cel_min = 0
    end
  end 

  def cel_min_by_date(worker_id,data)
    if Cele.all.include?(worker_id) == false
    cel_min = Cele.minimum(:ce_minimum, :conditions => ["ce_worker_id = ? and ce_data like ?", worker_id,"%#{data}%"])
    return cel_min
    else
     cel_min = 0
    end
  end

  def cel_max_by_date(worker_id,data)
    if Cele.all.include?(worker_id) == false
    cel_min = Cele.maximum(:ce_maximum, :conditions =>["ce_worker_id = ? and ce_data like ?", worker_id,"%#{data}%"])
    return cel_min
    else
      cel_min = 0
    end
  end   
  
  def cel_by_date_merx(worker_id,data,type)
    if Cele.all.include?(worker_id) == false
      if type == 'max'
       cel_min = Cele.where("ce_id_worker_merx = ? and ce_data like ?", worker_id,"%#{data}%").order('ce_data asc').pluck(:ce_maximum).first
      end
      if type == 'min'
       cel_min = Cele.where("ce_id_worker_merx = ? and ce_data like ?", worker_id,"%#{data}%").order('ce_data asc').pluck(:ce_minimum).first
      end
    return cel_min
    else
      cel_min = 0
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
  
  def relizacja_norm_last(worker_id,type)
      wartosc = Realizacjanorm.select("sum(rn_normatywy_czas_suma_tj) as suma").where("rn_id_worker_merx = ?",worker_id).group("rn_data").order("rn_data desc").pluck(:rn_normatywy_czas_suma_tj).first
      data = Realizacjanorm.where("rn_id_worker_merx = ?", worker_id).order("rn_data desc").pluck(:rn_data).first
      czas_dostepny = Tabelaczasowdostepnych.select("sum(tcd_sum_godz_przep) as suma").where("tcd_id_worker_merx =? and tcd_data like ?", worker_id, data).group("tcd_data").order("tcd_data desc").pluck(:tcd_sum_godz_przep).first
      if czas_dostepny != nil
        czas_dostepny = (czas_dostepny - czas_dostepny/8).round 
      else
        czas_dostepny = 450
      end 
      if czas_dostepny != nil and wartosc != nil
        
         efektywnosc = (wartosc/czas_dostepny*100).round
      else
        efektywnosc = 0
      end
      if type == 'cmax'
        celmax = cel_by_date_merx(worker_id,data,'max').to_f 
        if celmax != nil
          return celmax
        else 
          return 0
        end
      end
      if type == 'cmin'
        celmin = cel_by_date_merx(worker_id,data,'min').to_f
       if celmin != nil
          return celmin
        else 
          return 0
        end
      end
      if type == "efektywnosc"
        if efektywnosc != nil
          return  efektywnosc
        else
          return 0
        end
      end
      if type == "czas_dostepny"
        if czas_dostepny != nil 
          return  czas_dostepny
        else
          return 0
        end
      end
      if type == "realizacja_norm"
        if wartosc != nil 
          return  wartosc
        else
          return 0
        end
      end
  end

  def ostatni_poziom_zrealizowanego_celu(efektywnosc,cmin,cmax)
    if cmin != 0 and cmax != 0 and efektywnosc != 0
      wartosc = ((efektywnosc - cmin) / (cmax-cmin))*100
      return wartosc
    else
      return 0
    end 
  end

  def szczegolowe_dane_z_dnia(worker_id,data,type)
      realizacja_norm = Realizacjanorm.select("sum(rn_normatywy_czas_suma_tj) as suma").where("rn_id_worker_merx = ? and rn_data like ?",worker_id,data).group("rn_data").order("rn_data desc").pluck(:rn_normatywy_czas_suma_tj).first
      czas_dostepny = Tabelaczasowdostepnych.select("sum(tcd_sum_godz_przep) as suma").where("tcd_id_worker_merx =? and tcd_data like ?", worker_id, data).group("tcd_data").order("tcd_data desc").pluck(:tcd_sum_godz_przep).first
      if czas_dostepny == nil
        czas_dostepny = 480
      end
        if type == "efektywnosc"
              if realizacja_norm != nil and czas_dostepny != nil
              efektywnosc = realizacja_norm/(czas_dostepny - czas_dostepny/8)*100
              else
              efektywnosc = 0
              end
          return efektywnosc
        end

      if type == "czas_dostepny"
        if czas_dostepny == nil
          return 450.0
        else
          return  czas_dostepny - czas_dostepny/8
        end
      end
        if type == "realizacja_norm"
           return  realizacja_norm
        end
  end

  def realizacja_norm(limit)
    @normy = Realizacjanorm.where("rn_normatywy_czas_suma_tg >= ?", 0).order('rn_data desc').limit(limit)
    return @normy
  end

  def dodatek_by_obszar(obszar)
    if Obszar.all.include?(obszar) == false
    @dodatek ||= Obszar.where("ob_kod =? ", obszar).order('created_at desc').limit(1).pluck(:ob_wartosc)
    return @dodatek
  else
    @dodatek = 1
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
    @last_update_effectivity = Effectivenes.maximum(:ef_data, :conditions => ["worker_id = ?", worker_id])
    return @last_update_effectivity
  end


    def count_effectivity(worker_id)
      Effectivenes.count(:conditions => ["worker_id = ?", worker_id])
    end


  

  
end
