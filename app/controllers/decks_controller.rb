class DecksController < ApplicationController
  before_action :set_deck, only: %i[ show edit edit_name edit_private update update_name update_private destroy ]
  #Added this because kept getting error with invalid authenticity token. 
  #Suspect issue might be the use the app within the tool consumer window
  skip_before_action :verify_authenticity_token, :only => [:create, :update, :destroy]
  before_action :no_blanks, only: %i[create update_name]

  # GET /decks or /decks.json
  def index
    @user = current_user
    @decks = @user.decks
  end

  # GET /decks or /decks.json
  def public
    @user = current_user
    @decks = Deck.all.where(private: false)
  end

  # GET /decks/1 or /decks/1.json
  def show
    @user = current_user

    if !@deck.assignment.nil?
      @assignment = Assignment.find(@deck.assignment_id)
    end
    
    counter = 0;
    @user.reviews.each do |review|
      @deck.cards.each do |card|
        if review.card == card
          counter += 1
        end
      end
    end
    
    @new_cards = @deck.cards.count - counter
  end

  # GET /decks/new
  def new
    @deck = Deck.new
    @assignment = current_assignment
    @deck.user = current_user
  end

  # GET /decks/1/edit
  def edit
  end

  def edit_name
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_private
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /decks or /decks.json
  def create
    @deck = Deck.new(deck_params)

    if !params[:deck][:assignment_id].blank?
      @assignment = Assignment.find(params[:deck][:assignment_id])
      @course = @assignment.course
      @deck.assignments << @assignment
    end
   
    respond_to do |format|
      if @deck.save && !@assignment.blank?
        format.html { redirect_to deck_cards_path(@deck)}
        format.json { render :show, status: :created, location: @deck }
        format.js {render :create_and_assign}
      elsif @deck.save
        format.js
      else        
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  def copy_deck
    @user = current_user
    @target_deck = Deck.find(params[:deck_id])
    @deck = @target_deck.dup
    @deck.owner = @user
    @deck.private = true
    @deck.save!  
    @target_deck.cards.each_with_index do |card, index|
      new_card = card.dup
      new_card.update(deck_id: @deck.id)
      new_target = card.target.dup
      new_target.save!
      new_card.update(target_id: new_target.id)
    end

    respond_to do |format|
      if @deck.save && !@assignment.blank?
        format.html { redirect_to deck_cards_path(@deck)}
        format.json { render :show, status: :created, location: @deck }
        format.js {render :create_and_assign}
      elsif @deck.save
        format.js
      else        
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /decks/1 or /decks/1.json
  def update
    respond_to do |format|
      if @deck.update(deck_params)
        format.html { redirect_to @deck, notice: "Deck was successfully updated." }
        format.json { render :show, status: :ok, location: @deck }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decks/1 or /decks/1.json
  def destroy
    @deck.destroy
    respond_to do |format|
      format.html { redirect_to assignment_url(@deck.assignment, :user_id => @deck.user.id), notice: "Deck was successfully destroyed." }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    def no_blanks
      if params[:deck][:name].blank?
        params[:deck][:name] = "Deck No. #{current_user.decks.count + 1}"
      end
    end

    # Only allow a list of trusted parameters through.
    def deck_params
      params.require(:deck).permit(:name, :user_id, :private)
    end
end
