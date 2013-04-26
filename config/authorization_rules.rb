authorization do
	role :admin do	
		has_permission_on :workers, :to => [:index, :show, :lista, :new ,:create,:delete,:pracownik,:szczegoly,:import_render,:import,:import_tn,:import_tc, :import_tt]
		has_permission_on :searches, :to => [:new,:index,:create,:show,:combo_chart,:lista]
		has_permission_on :effectivenes, :to => [:index,:new,:delete,:create,:calendar]
		has_permission_on :celes, :to => [:new,:create,:delete]
		has_permission_on :premies, :to => [:new,:create,:delete]
		has_permission_on :tabelanormatywows, :to => [:index,:export,:create,:new,:delete]
		has_permission_on :tabelatransportowas, :to => [:index,:export,:create,:new,:delete]
		has_permission_on :typyczynnoscis, :to => [:new,:create,:index,:export,:delete]
		has_permission_on :pomocniczes, :to => [:new,:create,:create_dodatek,:index,:export,:delete,:delete_obszar,:delete_dodatek,
												:edit_obszar,:update_obszar, :edit_predkosc,:update_predkosc,:edit_dodatek,:update_dodatek]
	end

	role :dyrektor do	
		has_permission_on :workers, :to => [:index, :show, :lista, :new ,:create,:delete,:pracownik,:szczegoly,:import_render,:import]
		has_permission_on :searches, :to => [:new,:index,:create,:show]
	end
	role :kierownik do	
		has_permission_on :workers, :to => [:index, :show, :lista ,:create,:pracownik,:szczegoly,:import_render,:import]
	end

	role :pracownik do	
		has_permission_on :workers, :to => [:index, :szczegoly]
	end

	role :gosc do	
		has_permission_on :workers, :to => :index
	end
end