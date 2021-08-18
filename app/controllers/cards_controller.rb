class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy edit_illustrative_test edit_solution edit_target edit_explanation update_solution update_illustrative_test update_target update_explanation]
  before_action :set_deck
  before_action :no_blanks, only: %i[ create update_solution update_illustrative_test update_target update_explanation]

  # GET /cards or /cards.json
  def index
    @cards = @deck.cards
    @user = current_user
  end

  # GET /cards/1 or /cards/1.json
  def show
    @user = User.find(params[:user_id])
    @assignment = Assignment.find(params[:user_id])
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  def edit_target
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_illustrative_test
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_solution
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_explanation
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_deck_name
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /cards or /cards.json
  def create

    @target = Target.create(:target => params[:card][:target], :explanation => params[:card][:explanation])
    @card = Card.new(card_params.except(:target).merge(target_id: @target.id, deck_id: params[:deck_id]))
    
    respond_to do |format|
      if @card.save
        format.html { redirect_to deck_cards_path(@deck), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update_illustrative_test
    respond_to do |format|
      if @card.update(illustrative_test: params[:card][:illustrative_test])
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
        format.js 
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_solution
    respond_to do |format|
      if @card.update(solution: params[:card][:solution])
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
        format.js 
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_target
    respond_to do |format|
      if @card.target.update(target: params[:card][:target])
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
        format.js 
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_explanation
    respond_to do |format|
      if @card.target.update(explanation: params[:card][:explanation])
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
        format.js 
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_deck_name
    respond_to do |format|
      if @card.deck.update(name: params[:card][:deck_name])
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
        format.js 
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_path(:assignment_id => @card.deck.assignment.id, :user_id => @card.deck.user_id), notice: "Card was successfully destroyed." }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    def set_deck
      @deck = Deck.find(params[:deck_id])
    end

    def no_blanks
      if params[:card][:target].blank?
        params[:card][:target] = "Add Target"
      end
      if params[:card][:illustrative_test].blank?
        params[:card][:illustrative_test] = "Add Illustrative Test"
      end
      if params[:card][:solution].blank?
        params[:card][:solution] = "Add Solution"
      end
      if params[:card][:explanation].blank?
        params[:card][:explanation] = "Add Explanation"
      end
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:illustrative_test, :solution, :deck_id, :target)
    end
end
