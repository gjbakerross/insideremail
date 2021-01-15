class ApikeysController < ApplicationController
  before_action :set_apikey, only: [:show, :edit, :update, :destroy]

  # GET /apikeys
  # GET /apikeys.json
  def index
    @apikeys = Apikey.all
  end

  # GET /apikeys/1
  # GET /apikeys/1.json
  def show
  end

  # GET /apikeys/new
  def new
    @apikey = Apikey.new
  end

  # GET /apikeys/1/edit
  def edit
    @country_options = Country.all.map{ |c| [ c.name, c.id ] }
  end

  # POST /apikeys
  # POST /apikeys.json
  def create
    @apikey = Apikey.new(apikey_params)

    respond_to do |format|
      if @apikey.save
        format.html { redirect_to apikeys_url, notice: 'Apikey was successfully created.' }
        format.json { render :show, status: :created, location: @apikey }
      else
        format.html { render :new }
        format.json { render json: @apikey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apikeys/1
  # PATCH/PUT /apikeys/1.json
  def update
    respond_to do |format|
      if @apikey.update(apikey_params)
        format.html { redirect_to apikeys_url, notice: 'Apikey was successfully updated.' }
        format.json { render :show, status: :ok, location: @apikey }
      else
        format.html { render :edit }
        format.json { render json: @apikey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apikeys/1
  # DELETE /apikeys/1.json
  def destroy
    @apikey.destroy
    respond_to do |format|
      format.html { redirect_to apikeys_url, notice: 'Apikey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apikey
      @apikey = Apikey.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def apikey_params
      params.require(:apikey).permit(:apikey, :country_id)
    end
end
