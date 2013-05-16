class TabelaTransportowaDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Tabelatransportowa.count,
      iTotalDisplayRecords: transporty.total_entries,
      aaData: data
    }
  end

private

 # def dodatek_by_obszar(obszar)
 #    if Obszar.all.include?(obszar) == false
 #    @dodatek ||= Obszar.where("ob_kod =? ", obszar).order('created_at desc').limit(1).pluck(:ob_wartosc)
 #    return @dodatek
 #  else
 #    @dodatek = 1
 #  end

  def predkosc_po_kodzie(predkosc_kod)
    if Predkosci.all.include?(predkosc_kod) == true
    @predkosc = Predkosci.where("pr_kod = ?" , predkosc_kod).limit(1).pluck(:pr_predkosc_km)  
    return @predkosc
      else
    1
   end
  end

  def dodatek_po_kodzie(dodatek_kod)
    if Dodatki.all.include?(dodatek_kod) == true
      @dodatek = Dodatki.where("do_kod = ?" , dodatek_kod).limit(1).pluck(:do_czas_zakr)
    return @dodatek
    else
      0
    end
  end 
  
  def dodatek_start_po_kodzie(dodatek_kod_start)
    if Dodatki.all.include?(dodatek_kod_start) == true  
      @dodatek_start = Dodatki.where("do_kod = ?" , dodatek_kod_start).limit(1).pluck(:do_czas_start_stop)
    return @dodatek_start
    else
      0
    end
  end

  def data
    transporty.map do |transport|
      [
      transport.tt_nr_drogi,
      transport.tt_nr_drogi_system,
      transport.tt_przebieg_trasy,
      transport.tt_opis_trasy,
      transport.tt_typ_operacji,
      transport.tt_obszar,
      transport.tt_ruch_od,
      transport.tt_ruch_do,
      transport.tt_srodek_transportu,
      transport.tt_dystans_od.to_f.round(2),
      transport.tt_dystans_do.to_f.round(2),
      transport.tt_ilosc_zakretow,
      transport.tt_ilosc_start_stop,
      transport.tt_rodzaj_pobrania,
      transport.tt_predkosc_kod,
      transport.tt_dodatek_kod,
      (
        ((transport.tt_dystans_od.to_f + transport.tt_dystans_do.to_f) * (1/predkosc_po_kodzie(transport.tt_predkosc_kod)[0]*10/36)).to_f
         + 
         (transport.tt_ilosc_start_stop.to_i * dodatek_start_po_kodzie(transport.tt_srodek_transportu)[0].to_f) 
         + 
         (transport.tt_ilosc_zakretow.to_i * dodatek_po_kodzie(transport.tt_srodek_transportu)[0].to_f)
      ).round(2),
      transport.tt_komentarz,
      transport.created_at.strftime("%d-%m-%Y"),
      transport.tt_import_file_info 
      ]
    end
  end

  def transporty
    @transporty ||= fetch_transporty
  end

  def fetch_transporty
    transporty = Tabelatransportowa.order("#{sort_column} #{sort_direction}")
    transporty = transporty.page(page).per_page(per_page)
    if params[:sSearch].present?
      transporty = transporty.where("tt_nr_drogi like :search 
                           or tt_nr_drogi_system like :search
                         or tt_przebieg_trasy like :search
                         or tt_opis_trasy like :search
                         or tt_typ_operacji like :search
                         or tt_obszar like :search
                         or tt_ruch_od like :search
                         or tt_ruch_do like :search
                         or tt_srodek_transportu like :search
                         or tt_dystans_od like :search
                         or tt_dystans_do like :search
                         or tt_ilosc_zakretow like :search
                         or tt_ilosc_start_stop like :search
                         or tt_rodzaj_pobrania like :search
                         or tt_predkosc_kod like :search
                         or tt_dodatek_kod like :search
                         or 16 like :search
                         or tt_komentarz like :search
                         or created_at like :search
                         or tt_import_file_info like :search
                         ", search: "%#{params[:sSearch]}%")
    end
    transporty
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[tt_nr_drogi 
                  tt_nr_drogi_system 
                  tt_przebieg_trasy 
                  tt_opis_trasy 
                  tt_typ_operacji 
                  tt_ruch_od 
                  tt_ruch_do 
                  tt_srodek_transportu 
                  tt_dystans_od  
                  tt_dystans_do
                  tt_ilosc_zakretow
                  tt_ilosc_start_stop
                  tt_rodzaj_pobrania
                  tt_predkosc_kod
                  tt_dodatek_kod
                  tt_komentarz
                  created_at
                  tt_import_file_info
                  ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end