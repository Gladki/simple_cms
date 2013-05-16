class NormatywyDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Tabelanormatywow.count,
      iTotalDisplayRecords: normatyw.total_entries,
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
    normatyw.map do |norma|
      [
       norma.tn_kod_czynnosci, 
       norma.tn_obszar, 
       norma.tn_opis_czynnosci, 
       norma.tn_opis_czynnosci_szczegolowy, 
       norma.tn_jednostka_odniesienia.to_f.round(2), 
       norma.tn_czas.to_f.round(2),
       (norma.tn_czas.to_f/60).round(2),
       norma.tn_komentarz,
       norma.tn_import_file_info,
       norma.created_at.strftime("%d-%m-%Y")
       
      ]
    end
  end

  def normatyw
    @normatyw ||= fetch_normatyw
  end

  def fetch_normatyw
    normatyw = Tabelanormatywow.order("#{sort_column} #{sort_direction}")
    normatyw = normatyw.page(page).per_page(per_page)
    if params[:sSearch].present?
      normatyw = normatyw.where("tn_kod_czynnosci like :search 
                 or tn_obszar like :search 
                 or tn_opis_czynnosci like :search 
                 or tn_opis_czynnosci_szczegolowy like :search 
                 or tn_jednostka_odniesienia like :search 
                 or tn_czas like :search
                 or tn_komentarz like :search
                 or tn_import_file_info like :search
                 or created_at like :search", search: "%#{params[:sSearch]}%")
    end
    normatyw
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[
                tn_kod_czynnosci 
                tn_obszar 
                tn_opis_czynnosci 
                tn_opis_czynnosci_szczegolowy 
                tn_jednostka_odniesienia 
                tn_czas
                tn_komentarz
                tn_import_file_info
                created_at
               ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end