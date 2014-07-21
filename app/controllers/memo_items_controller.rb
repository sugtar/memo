class MemoItemsController < ApplicationController
  before_action :set_memo_item, only: [:show, :edit, :update, :destroy]

  # GET /memo_items
  # GET /memo_items.json
  def index
    @memo_items = MemoItem.all
  end

  # GET /memo_items/1
  # GET /memo_items/1.json
  def show
  end

  # GET /memo_items/new
  def new
    @memo_item = MemoItem.new
  end

  # GET /memo_items/1/edit
  def edit
  end

  # POST /memo_items
  # POST /memo_items.json
  def create
    @memo_item = MemoItem.new(memo_item_params)

    respond_to do |format|
      if @memo_item.save
        format.html { redirect_to @memo_item, notice: 'Memo item was successfully created.' }
        format.json { render :show, status: :created, location: @memo_item }
      else
        format.html { render :new }
        format.json { render json: @memo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memo_items/1
  # PATCH/PUT /memo_items/1.json
  def update
    respond_to do |format|
      if @memo_item.update(memo_item_params)
        format.html { redirect_to @memo_item, notice: 'Memo item was successfully updated.' }
        format.json { render :show, status: :ok, location: @memo_item }
      else
        format.html { render :edit }
        format.json { render json: @memo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memo_items/1
  # DELETE /memo_items/1.json
  def destroy
    @memo_item.destroy
    respond_to do |format|
      format.html { redirect_to memo_items_url, notice: 'Memo item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo_item
      @memo_item = MemoItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memo_item_params
      params.require(:memo_item).permit(:body)
    end
end
