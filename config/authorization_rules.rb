authorization do
	role :admin do	
		has_permission_on :workers, :to => [:index, :show, :lista, :new ,:create,:delete,:pracownik,:szczegoly,:import_render,:import,:import_tn,:import_tc, :import_tt]
		has_permission_on :searches, :to => [:new,:index,:create,:show]
		has_permission_on :effectivenes, :to => [:index,:calendar]
		has_permission_on :tabelanormatywows, :to => [:index,:export,:create,:new,:delete]
		has_permission_on :tabelatransportowas, :to => [:index,:export,:create,:new,:delete]
		has_permission_on :typyczynnoscis, :to => [:new,:create,:index,:export,:delete]
		has_permission_on :pomocniczes, :to => [:new,:create,:create_dodatek,:index,:export,:delete,:delete_dodatek]
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