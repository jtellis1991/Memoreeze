class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  after_action :check_if_study_complete, only: %i[ create ]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    
    respond_to do |format|
      if @review.save
        # create a result for the review that logs the response of the learner
        @result = @review.create_result(result: params[:result].downcase)
        # update the card account with the new interval and advance the next review due by the interval
        @review.card_account.update(last_interval: params[:review][:interval], next_review_due: @review.card_account.next_review_due.to_date.advance(days: params[:review][:interval].to_i))
        format.html { redirect_to course_assignment_path(current_course, current_assignment), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:milliseconds_elapsed, :card_account_id, :user_id)
    end
    
    def current_time
      Time.now.in_time_zone(@review.card.user.review_setting.time_zone)
    end

    def card_accounts_due
      @deck_account = @user.deck_accounts.find_by(deck_id: current_assignment.deck.id)
      @card_accounts_due = []
      @deck_account.card_accounts.each do |card_account|
        if card_account.next_review_due.to_date === today.to_date
          @card_accounts_due << card_account
        end
      end
      return @card_accounts_due
    end

    def check_if_study_complete
      if card_accounts_due.count == 0
        @user.deck_accounts.find_by(deck_id: @assignment.deck.id).update(is_todays_study_complete: true)
      end
    end
end
