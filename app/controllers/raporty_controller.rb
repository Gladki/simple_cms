class RaportyController < ApplicationController
 layout 'worker'

def premie
    @nowa_premia = Premie.new
	@premie = Premie.find(:all, :order => "id DESC")
end




end
