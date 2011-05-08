class IntegrationsController < ApplicationController
  def index
    @integrations = Integration.all
  end

  def new
    @integration = Integration.new
  end

  def create
    @integration = Integration.new params[:integration]

    if @integration.valid?
      @integration.save!
      redirect_to root_url, :notice => 'Integration created.'
    else
      respond_to do |format|
        format.html { render :action => 'new' }
      end
    end
  end
end
