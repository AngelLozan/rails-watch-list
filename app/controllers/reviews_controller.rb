class ReviewsController < ApplicationController
  before_action :set_list, only: %i[new create show]


  # GET /reviews/new
  def new
    @review = Review.new
  end


  def create
    @review = Review.new(review_params)
    @review.list = @list
    respond_to do |format|
      if @review.save
        format.html { redirect_to list_url(@list), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:list_id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:content, :rating)
    end
end
