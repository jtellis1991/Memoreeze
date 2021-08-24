class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[ show edit edit_deck update destroy ]
  before_action :set_course

  # GET /assignments or /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1 or /assignments/1.json
  def show
    @user = current_user
    @card_accounts_due = card_accounts_due
    @today = today
    @first_due = @card_accounts_due.first
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  def edit_deck
    @user = current_user
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /assignments or /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: "Assignment was successfully created." }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1 or /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: "Assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @assignment }
        format.js 
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1 or /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: "Assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def card_accounts_due
      @deck_account = @user.deck_accounts.find_by(deck_id: @assignment.deck.id)
      @card_accounts_due = []
      @deck_account.card_accounts.each do |card_account|
        if card_account.next_review_due.to_date === today.to_date
          @card_accounts_due << card_account
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def assignment_params
      params.require(:assignment).permit(:course_id, :deck_id)
    end
end
