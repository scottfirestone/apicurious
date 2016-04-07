class Playlist
  attr_reader :name,
              :ext_url,
              :images,
              :id,
              :owner,
              :public,
              :track_count,
              :track_href

  def initialize(params)
    @name = params[:name]
    @ext_url = params[:external_urls][:spotify]
    @images = params[:images].first[:url]
    @id = params[:id]
    @owner = params[:owner][:id]
    @public = params[:public]
    @track_count = params[:tracks][:total]
    @track_href = params[:tracks][:href]
  end
end
