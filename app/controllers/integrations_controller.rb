class IntegrationsController < ApplicationController
  def index
    @integrations = Integration.all
  end

  def new
    @integration = Integration.new
  end

  def enqueue
    # This is just to make sure the integration exists...
    integration = Integration.find params[:id]
    raise "Integration not found." if integration.nil?

    build = Build.create :integration => integration

    Resque.enqueue BuildQueue, build.id
    redirect_to root_url, :notice => "#{integration.name} has been enqueued."
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
