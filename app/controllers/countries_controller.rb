class CountriesController < ApplicationController

  caches_page :index_page_cached
  caches_action :index_action_cached
  cache_sweeper :country_sweeper
  
  def index
    @countries = Country.all
    # @countries = Country.all_states_included
    # @countries = Country.all_states_and_counts_included
  end

  def index_page_cached
    @countries = Country.all_states_and_counts_included
  end

  def index_action_cached
    @countries = Country.all_states_and_counts_included
  end

  def index_fragment_cached
    @countries = Country.all_states_and_counts_included
    @recent_countries = Country.order('updated_at desc').limit 5
  end

  def index_sql_cached
    @countries = Rails.cache.fetch('sql_countries') do
      Country.all_states_and_counts_included.all
    end
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country }
    end
  end

  # GET /countries/new
  # GET /countries/new.json
  def new
    @country = Country.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(params[:country])
    if @country.save
      redirect_to @country, notice: 'Country was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /countries/1
  # PUT /countries/1.json
  def update
    @country = Country.find(params[:id])

    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    respond_to do |format|
      format.html { redirect_to countries_url }
      format.json { head :no_content }
    end
  end
end
