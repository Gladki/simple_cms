class CzynnosciDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Typyczynnosci.count,
      iTotalDisplayRecords: czynnosci.total_entries,
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
 #  end
  
  def data
    czynnosci.map do |czynnosc|
      [
        czynnosc.tc_kod, 
        czynnosc.tc_opis,
        czynnosc.tc_zrodlo_pochodzenia,
        czynnosc.created_at.strftime("%d-%m-%Y")
       
      ]
    end
  end

  def czynnosci
    @czynnosci ||= fetch_czynnosci
  end

  def fetch_czynnosci
    czynnosci = Typyczynnosci.order("#{sort_column} #{sort_direction}")
    czynnosci = czynnosci.page(page).per_page(per_page)
    if params[:sSearch].present?
      czynnosci = czynnosci.where("
        tc_kod like :search 
        or tc_opis like :search
        or tc_zrodlo_pochodzenia like :search
        or created_at like :search", search: "%#{params[:sSearch]}%")
    end
    czynnosci
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[
                tc_kod 
                tc_opis
                tc_zrodlo_pochodzenia
                created_at
               ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end