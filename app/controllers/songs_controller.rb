class SongsController < ApplicationController
  def index
    if params[:artist_id]
      find_song
      @artist = @songs.artists
    else
      @songs = Song.all
      flash[:alert] = "Atrist not found"
      redirect_to artist_url
    end
  end

  def show
    @song = Song.find(params[:id])
    # @song.valid?
    #   flash[:alert] = "Song not found"
    #  redirect_to artist_songs
    # redirect_to  @song
    #redirect_to artist_path(@artist)
    
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def find_song
    @song = Artist.find_by_id(params[:artist_id])
  end

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

