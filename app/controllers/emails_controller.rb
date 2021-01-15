class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :edit, :update, :destroy]

  require 'uri'
  require 'net/http'
  require 'openssl'

  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.all

  end

  # GET /emails/1
  # GET /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @email = Email.new
    @country_options = Country.all.map{ |c| [ c.name, c.id ] }
  end

  # GET /emails/1/edit
  def edit
    @country_options = Country.all.map{ |c| [ c.name, c.id ] }
    email = Email.find(params[:id])
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = Email.new(email_params)
      if @email.save
        update_insider(@email.country, @email.email)
      else
        # format.html { render :new }
        # format.json { render json: @email.errors, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /emails/1
  # PATCH/PUT /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to emails_url, notice: 'Email was successfully updated.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_insider(country,email)
    puts country.apikey.apikey
    url = URI("https://email.useinsider.com/v1/email/unsubscribe")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = 'application/json'
    request["X-INS-AUTH-KEY"] = "#{country.apikey.apikey}"
    request["cache-control"] = 'no-cache'
    request.body = {email: email}.to_json

    response = http.request(request)
    if response.code == "202"
      redirect_to emails_url, notice: 'Email was successfully updated on Insider.' 
    else
      render :new, notice: 'Unsuccesful update'
    end 
  end

  def export_emails
    # redirect_to :index
    @emails = Email.all
    send_data @emails.to_email_csv, filename: "email-#{Date.today}.csv"
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:email, :country_id)
    end
end
