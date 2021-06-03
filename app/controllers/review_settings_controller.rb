class ReviewSettingsController < ApplicationController
  before_action :set_review_setting, only: %i[ show edit update destroy ]

  # GET /review_settings or /review_settings.json
  def index
    @review_settings = ReviewSetting.all
  end

  # GET /review_settings/1 or /review_settings/1.json
  def show
  end

  # GET /review_settings/new
  def new
    @review_setting = ReviewSetting.new
  end

  # GET /review_settings/1/edit
  def edit
  end

  # POST /review_settings or /review_settings.json
  def create
    @review_setting = ReviewSetting.new(review_setting_params)

    respond_to do |format|
      if @review_setting.save
        format.html { redirect_to @review_setting, notice: "Review setting was successfully created." }
        format.json { render :show, status: :created, location: @review_setting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /review_settings/1 or /review_settings/1.json
  def update
    respond_to do |format|
      if @review_setting.update(review_setting_params)
        format.html { redirect_to @review_setting, notice: "Review setting was successfully updated." }
        format.json { render :show, status: :ok, location: @review_setting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /review_settings/1 or /review_settings/1.json
  def destroy
    @review_setting.destroy
    respond_to do |format|
      format.html { redirect_to review_settings_url, notice: "Review setting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review_setting
      @review_setting = ReviewSetting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_setting_params
      params.require(:review_setting).permit(:user_id, :reviews_per_day, :new_per_day)
    end
end
