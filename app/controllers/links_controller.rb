class LinksController < ApplicationController

  layout 'application'

  def index
    @links = Link.all

    respond_to do |format|
      format.html { render :index }
      format.json { render json: can_json(@links) }
    end
  end

  def create
    # NOTE: This will just return the return value of save to the client
    render text: @link = Link.new(link: params[:link], 
                                  embedded_link: params[:embedded_link], 
                                  name: params[:name]).save.to_s
  end

  def update
    @link = Link.find(params[:id])
    @link.update_attributes(params[:link])
  end

  def destroy
    @link = Link.find(params[:id]).delete
  end
end
