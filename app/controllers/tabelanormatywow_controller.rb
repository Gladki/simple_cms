class TabelanormatywowController < ApplicationController
 

    filter_access_to :all

 layout 'worker'
before_filter :normatywy_all, :only => [:index,:export]


def normatywy_all
    @normatywy = Tabelanormatywow.all
end



def index
  end

def export
	respond_to do |format|
    	format.html
    	format.xls 	
	end
end

end
