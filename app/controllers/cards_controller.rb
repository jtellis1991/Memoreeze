class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy ]
  #Added this because kept getting error with invalid authenticity token. 
  #Suspect issue might be the use the app within the tool consumer window
  skip_before_action :verify_authenticity_token, :only => [:create, :update, :destroy]

  # GET /cards or /cards.json
  def index
    @cards = Assignment.find(params[:assignment_id]).decks.first.cards
    @assignment = Assignment.find(params[:assignment_id])
    @deck = @assignment.decks.first
    @user = User.find(params[:user_id])
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

  def edit_front
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_back
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params.except(:target))
    @card.build_target(:body => params[:card][:target])

    respond_to do |format|
      if @card.save
        format.html { redirect_to cards_path(:assignment_id => @card.deck.assignment.id, :user_id => @card.deck.user_id), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
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
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:front, :back, :deck_id, :target)
    end
end
