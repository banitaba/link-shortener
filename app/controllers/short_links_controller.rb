class ShortLinksController < ApplicationController
  before_action :fetch_short_link, only: [ :show, :edit, :update]

  def index
    shortened_url = ShortLink.where("MD5(original_url) = '"+ params[:short_url]+"' ").first
    if shortened_url
       shortened_url.view_count += 1
       shortened_url.save
       redirect_to shortened_url.original_url
    end
  end

  def new
    @short_link = ShortLink.new
  end

  def create
    shortened_url = ShortLink.where(original_url: short_link_params['original_url']).first
    if !shortened_url
      shortened_url = ShortLink.new(short_link_params)    
      shortened_url.save
    end
    redirect_to :action => "show", :id => shortened_url.id   
  end

  def show
    #render plain: @short_link.id
    md5hash = Digest::MD5.hexdigest @short_link.original_url
    @short_link_url = URI.join(request.original_url,'/') + '/s/'+ md5hash
  end

  def edit
  end

  def update
    if @short_link.update whatdoes: :this_do
      redirect_to :somewhere
    else
      redirect_to :somewhere_else
    end
  end

  private

  def fetch_short_link
    @short_link = ShortLink.find(params[:id])
  end

  def short_link_params
    params.require(:short_link).permit(:original_url)
  end
end
