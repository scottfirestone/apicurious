class PlaylistTrack
  attr_reader :title,
              :artist

  def initialize(params)
    
    @title  = params[:track][:name]
    @artist = params[:track][:artists].first[:name]
    @uri    = params[:track][:uri]
  end
end
