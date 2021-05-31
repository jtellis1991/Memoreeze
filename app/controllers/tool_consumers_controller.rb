class ToolConsumersController < ApplicationController
  before_action :set_tool_consumer, only: %i[ show edit update destroy ]

  # GET /tool_consumers or /tool_consumers.json
  def index
    @tool_consumers = ToolConsumer.all
  end

  # GET /tool_consumers/1 or /tool_consumers/1.json
  def show
  end

  # GET /tool_consumers/new
  def new
    @tool_consumer = ToolConsumer.new
  end

  # GET /tool_consumers/1/edit
  def edit
  end

  # POST /tool_consumers or /tool_consumers.json
  def create
    @tool_consumer = ToolConsumer.new(tool_consumer_params)

    respond_to do |format|
      if @tool_consumer.save
        format.html { redirect_to @tool_consumer, notice: "Tool consumer was successfully created." }
        format.json { render :show, status: :created, location: @tool_consumer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tool_consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tool_consumers/1 or /tool_consumers/1.json
  def update
    respond_to do |format|
      if @tool_consumer.update(tool_consumer_params)
        format.html { redirect_to @tool_consumer, notice: "Tool consumer was successfully updated." }
        format.json { render :show, status: :ok, location: @tool_consumer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tool_consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tool_consumers/1 or /tool_consumers/1.json
  def destroy
    @tool_consumer.destroy
    respond_to do |format|
      format.html { redirect_to tool_consumers_url, notice: "Tool consumer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool_consumer
      @tool_consumer = ToolConsumer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tool_consumer_params
      params.require(:tool_consumer).permit(:guid, :name)
    end
end
