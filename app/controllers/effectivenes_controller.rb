class EffectivenesController < ApplicationController

layout 'admin'

  def index
  @effectivenes = Effectivenes.order(:id)
  respond_to do |format|
    format.html
    format.csv { send_data @effectivenes.to_csv }
    format.xls # { send_data @effectivenes.to_csv(col_sep: "\t") }
      #send_data   
    end
  end

def javascript
  
end


end
