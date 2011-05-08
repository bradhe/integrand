class IntegrationsController < ApplicationController
  def index
  end

  def new
    @integration = Integration.new(:source_repository => SourceRepository.new)
  end

  def create
    source_repository = SourceRepository.new params[:integration][:source_repository]
    # TODO: Implement creation logic, etc. here
    params[:integration][:source_repository] = source_repository
    @integration = Integration.new params[:integration]

    if @integration.valid?
      redirect_to root_url, :flash => 'Integration created.'
    else
      respond_to do |format|
        format.html { render :action => 'new' }
      end
    end
  end
end
