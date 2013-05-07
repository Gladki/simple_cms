class NormsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Realizacjanorm.count,
      iTotalDisplayRecords: normy.total_entries,
      aaData: data
    }
  end

private

 def dodatek_by_obszar(obszar)
    if Obszar.all.include?(obszar) == false
    @dodatek ||= Obszar.where("ob_kod =? ", obszar).order('created_at desc').limit(1).pluck(:ob_wartosc)
    return @dodatek
  else
    @dodatek = 1
  end
  end


  def data
    normy.map do |norma|
      [
       norma.rn_id_worker,
       norma.rn_id_worker_hr,
       norma.rn_id_worker_merx,
       norma.rn_data.strftime("%Y-%m-%d"), 
       norma.rn_obszar,
       norma.rn_magazyn,
       norma.rn_typ_operacji,
       norma.rn_normatywy_czas_suma_tg,
       (norma.rn_normatywy_czas_suma_tg * (100 +  dodatek_by_obszar(norma.rn_obszar)[0].to_f )/100).round(2) ,
       norma.rn_komentarz
      ]
    end
  end

  def normy
    @normy ||= fetch_normy
  end

  def fetch_normy
    normy = Realizacjanorm.order("#{sort_column} #{sort_direction}")
    normy = normy.page(page).per_page(per_page)
    if params[:sSearch].present?
      normy = normy.where("rn_id_worker like :search 
                           or rn_id_worker_hr like :search
                           or rn_id_worker_merx like :search
                           or rn_obszar like :search
                           or rn_magazyn like :search
                           or rn_typ_operacji like :search
                           or rn_data like :search", search: "%#{params[:sSearch]}%")
    end
    normy
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[rn_id_worker rn_id_worker_hr rn_id_worker_merx rn_data rn_obszar rn_magazyn rn_typ_operacji rn_normatywy_czas_suma_tg rn_normatywy_czas_suma_tj  rn_komentarz]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end