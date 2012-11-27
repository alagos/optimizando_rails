class CountrySweeper < ActionController::Caching::Sweeper
  observe Country

  def after_create(country)
    expire_cache_for(country)
  end
 
  def after_update(country)
    expire_cache_for(country)
  end
 
  def after_destroy(country)
    expire_cache_for(country)
  end
 
  private
  def expire_cache_for(country)
    expire_page(:controller => 'countries', :action => 'index_page_cached')
    expire_action(:controller => 'countries', :action => 'index_action_cached')
    expire_fragment('recent_countries')
  end
end