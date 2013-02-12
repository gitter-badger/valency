class CodingFramesController < ApplicationController
  before_filter :get_language
  
  def get_language
    @language = Language.includes(:coding_frames).find_by_name_for_url(params[:language_id])
  end
  
  # GET /languages/russian/coding_frames[.json]
  def index
    @coding_frames = @language.coding_frames.includes(:verbs)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coding_frames }
    end
  end

  # GET /languages/russian/coding_frames/1[.json]
  def show
    @coding_frame = @language.coding_frames.includes(:verbs).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coding_frame }
    end
  end

end
