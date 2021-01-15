class ApikeysController < ApplicationController

    def index
        @apikeys = Apikey.all   
    end

    def show
    end


    def edit
        @country_options = Country.all.map{ |c| [ c.name, c.id ] }
        apikey = Apikey.find(params[:id])
    end

    def update
        respond_to do |format|
          if @apikey.update(apikey_params)
            format.html { redirect_to apikeys_url, notice: 'API Key was successfully updated.' }
            format.json { render :show, status: :ok, location: @apikey }
          else
            format.html { render :edit }
            format.json { render json: @apikey.errors, status: :unprocessable_entity }
          end
        end
    end

    private

    def set_apikey
        @apikey = Apikey.find(params[:id])
      end
    def apikey_params
        params.require(:apikey).permit(:apikey, :country_id)
    end



end