class ItemsController < ApplicationController
  before_action :set_checklist, only: %i[new create show edit move]
  before_action :set_item, only: %i[show edit update destroy move]

  # GET /checklists/1/items/new
  def new
    @item = @checklist.items.new
  end

  # POST /items or /items.json
  def create
    @item = @checklist.items.create!(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @checklist }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def move
    @item.insert_at(item_params[:new_position].to_i)
    head :no_content
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: "item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_checklist
      @checklist = Checklist.find(params[:checklist_id])
    end

    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:description, :checklist_id, :position, :new_position)
    end
end
