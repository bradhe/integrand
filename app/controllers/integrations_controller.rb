class IntegrationsController < ApplicationController
  def index
    @integrations = Integration.all
  end

  def show
    @integration = Integration.find(params[:id])
  end

  def new
    @integration = Integration.new
  end

  def edit
    @integration = Integration.find(params[:id])
  end

  def update
    @integration = Integration.find(params[:id])
    @integration.update_attributes(params[:integration])

    if @integration.valid?
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
      end
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
      end
    end
  end

  def enqueue
    # This is just to make sure the integration exists...
    integration = Integration.find params[:id]
    raise "Integration not found." if integration.nil?

    build = Build.create :integration => integration

    Resque.enqueue BuildQueue, build.id
    redirect_to integrations_url, :notice => "#{integration.name} has been enqueued."
  end

  def create
    @integration = Integration.new params[:integration]

    if @integration.valid?
      @integration.save!
      redirect_to integrations_url, :notice => 'Integration created.'
    else
      respond_to do |format|
        format.html { render :action => 'new' }
      end
    end
  end
end
