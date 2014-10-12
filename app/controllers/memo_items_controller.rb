class MemoItemsController < ApplicationController
  before_action :set_memo_item, only: [:show, :edit, :update, :destroy, :new_related_item]

  # GET /memo_items
  # GET /memo_items.json
  def index
    @memo_items = MemoItem.all
  end

  # GET /memo_items/1
  # GET /memo_items/1.json
  def show
    if @memo_item.has_metadatum?("web app part")
      show_web_app_part
    else
      # show normal view
    end
  end

  def show_alt
    #create map from target_id to memo_item
    target_id_to_memo_item_map = Hash.new
    target_memo_items = @memo_item.target_items
    target_memo_items.each do |item|
      target_id_to_memo_item_map[item.id] = item
    end

    relationships = @memo_item.relationships

    # create RelationshipName id to name map
    ## collect relationship name ids
    relationship_name_ids = Array.new
    relationships.each do |relationship|
      relationship_name_ids << relationship.name_id
    end
    relationship_name_ids.uniq!

    ## create the map
    relationship_id_name_map = Hash.new

    ### get data from db
    relationship_names = RelationshipName.find(relationship_name_ids)
    ### create the map from the data
    relationship_names.each do |relationship_name|
      relationship_id_name_map[relationship_name.id] = relationship_name.name
    end

    # create maps from RelationshipName to MemoItems
    @relationship_name_to_memo_items_map = Hash.new
    relationships.each do |relationship|
      relationship_name = relationship_id_name_map[relationship.name_id]
      if @relationship_name_to_memo_items_map[relationship_name.intern] == nil
        @relationship_name_to_memo_items_map[relationship_name.intern] = Array.new
      end
      @relationship_name_to_memo_items_map[relationship_name.intern] << target_id_to_memo_item_map[relationship.target_item_id]
      # DEBUG: check memo_item append to the array
    end
  end

  # GET /memo_items/new
  def new
    @memo_item = MemoItem.new
  end

  # GET /memo_items/1/edit
  def edit
    @metadata = @memo_item.metadata
    # should create/use helper?
    @metadata_str = ""
    if @metadata != nil || @metadata.length > 0
      @metadata.each do |item|
        @metadata_str << (item.name + ", ")
      end
      @metadata_str = @metadata_str[0, (@metadata_str.length - 2)]
    end
  end

  def new_related_item
    #@memo_item = MemoItem.find(params[:id])
    @new_memo_item = MemoItem.new
    @relationship = Relationship.new
    @relationship.source_item = @memo_item
  end

  def create_related_item

    # for debug
    memo_item_params.each do |key, value|
      logger.debug("memot_item_param: key=" + key + ", value=" + value)
    end

    # request parameters
    relation_name = params[:relation_name]
    source_item_id = params[:source_item_id]
    metadata = params[:metadata]

    @source_memo_item = MemoItem.find(source_item_id)

    @memo_item = MemoItem.new(memo_item_params)
    if @memo_item.save

      # handle metadata
      if metadata != nil
        metadata_items = metadata.split(",")
        metadata_items.each do |item|
          item.strip!
          metadatum = Metadatum.find_or_create_by(name: item)
          @memo_item.metadata << metadatum
        end
      end

      # handle relationship
      if relation_name != nil
        relation_name.strip!
        relationship_name = RelationshipName.find_or_create_by(name: relation_name)
        relationship = Relationship.new
        relationship.source_item_id = @source_memo_item.id
        relationship.target_item_id = @memo_item.id
        relationship.name_id = relationship_name.id
        relationship.save # to be checked
      end
    end

    redirect_to @source_memo_item, notice: 'Memo item was succesfully created.'

  end

  # POST /memo_items
  # POST /memo_items.json
  def create
    # test code
    memo_item_params.each do |key, value|
      logger.debug("key:" + key + ", value: " + value);
    end 

    @memo_item = MemoItem.new(memo_item_params)

    respond_to do |format|
      if @memo_item.save

        # create matadata
        metadata = params[:metadata]
        if metadata != nil
          metadata_items = metadata.split(",")
          metadata_items.each do |item|
            item.strip! # trim white space

            metadatum = Metadatum.find_or_create_by(name: item)

            # create relation
            @memo_item.metadata << metadatum
          end
        end

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

        current_metadata = @memo_item.metadata
        current_metadata_names = current_metadata.map{|item| item.name}

        new_metadata_names = []
        params[:metadata].split(",").each do |item|
          new_metadata_names << item.strip
        end

        to_be_deleted = current_metadata_names - new_metadata_names
        to_be_added = new_metadata_names - current_metadata_names

        to_be_deleted.each do |name|
          @memo_item.metadata.delete(Metadatum.where(name: name).first)
        end

        to_be_added.each do |name|
          @memo_item.metadata << Metadatum.find_or_create_by(name: name)
        end

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

  def show_web_app_part
    # prepare sub items
    @html_item = nil
    @javascript_item = nil
    @css_item = nil
    
    implementation_items = Array.new

    @memo_item.relationships.each do |relationship|
      if relationship.name.name == "implementation"
        implementation_items << relationships.target_item
      end
    end

    implementation_items.each do |item|
      if item.has_metadatum?("code")
        if item.has_metadatum?("html")
          @html_item = item
        elsif item.has_metadatum?("javascript")
          @javascript_item = item
        elsif item.has_metadatum?("css")
          @css_item = item
        end
      end
    end

    render "show_web_app_part"
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
