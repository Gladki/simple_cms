class CzasyDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Tabelaczasowdostepnych.count,
      iTotalDisplayRecords: czasy.total_entries,
      aaData: data
    }
  end

private

  def data
    czasy.map do |czas|
      [
        czas.tcd_id_worker, 
        czas.tcd_id_worker_merx, 
        czas.tcd_sum_godz_przep, 
        (czas.tcd_sum_godz_przep - (((czas.tcd_sum_godz_przep)/8)*0.5).round(2)),
        czas.tcd_data, 
        czas.tcd_import_file_info,
        czas.created_at.strftime("%d-%m-%Y")
      ]
    end
  end

  def czasy
    @czasy ||= fetch_czasy
  end

  def fetch_czasy
    czasy = Tabelaczasowdostepnych.order("#{sort_column} #{sort_direction}")
    czasy = czasy.page(page).per_page(per_page)
    if params[:sSearch].present?
      czasy = czasy.where("
                          or tcd_id_worker like :search 
                          or tcd_id_worker_merx like :search 
                          or tcd_data like :search 
                          or tcd_sum_godz_przep like :search 
                          or tcd_import_file_info like :search
                          or created_at like :search", search: "%#{params[:sSearch]}%")
    end
    czasy
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[
                 tcd_id_worker 
                 tcd_id_worker_merx 
                 tcd_data 
                 tcd_sum_godz_przep 
                 tcd_import_file_info
               ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end