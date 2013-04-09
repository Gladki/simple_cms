class EffectivenesController < ApplicationController
   filter_access_to :all
layout 'worker'

  def index
  @effectivenes = Effectivenes.order(:id)
  respond_to do |format|
    format.html
    format.csv { send_data @effectivenes.to_csv }
    format.xls # { send_data @effectivenes.to_csv(col_sep: "\t") }
      #send_data   
    end
  end
  def calendar
  	 @efectivenes = Effectivenes.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  	
  end

def javascript
  
end


end
