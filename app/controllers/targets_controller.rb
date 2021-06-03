class TargetsController < ApplicationController
  before_action :set_target, only: %i[ show edit update destroy ]

  # GET /targets or /targets.json
  def index
    @targets = Target.all
  end

  # GET /targets/1 or /targets/1.json
  def show
  end

  # GET /targets/new
  def new
    @target = Target.new
  end

  # GET /targets/1/edit
  def edit
  end

  # POST /targets or /targets.json
  def create
    @target = Target.new(target_params)

    respond_to do |format|
      if @target.save
        format.html { redirect_to @target, notice: "Target was successfully created." }
        format.json { render :show, status: :created, location: @target }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /targets/1 or /targets/1.json
  def update
    respond_to do |format|
      if @target.update(target_params)
        format.html { redirect_to @target, notice: "Target was successfully updated." }
        format.json { render :show, status: :ok, location: @target }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /targets/1 or /targets/1.json
  def destroy
    @target.destroy
    respond_to do |format|
      format.html { redirect_to targets_url, notice: "Target was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target
      @target = Target.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def target_params
      params.require(:target).permit(:body, :card_id)
    end
end
