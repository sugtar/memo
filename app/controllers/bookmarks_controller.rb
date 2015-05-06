class BookmarksController < ApplicationController

  def index
    @bookmarks = Array.new
    # get bookmark items
    bookmark_metadatum = Metadatum.find_by(name: '#bookmark')
    bookmark_metadatum.memo_items.each do |item|
      bookmark_data = view_context.get_bookmark_data(item.id)
      @bookmarks << bookmark_data
    end
  end

  def new
    @url = params[:url]
    @title = params[:title]
    tmp = request.original_url.split('?')
    @base_url = tmp[0]
  end

  def create
    # create memo_item of bookmark url
    @url_memo_item = MemoItem.new(body: params[:url])
    @url_memo_item.save
    bookmark_metadatum = Metadatum.find_or_create_by(name: '#bookmark')
    @url_memo_item.metadata << bookmark_metadatum

    # create memo_item of comment and metadata
    @comment_memo_item = MemoItem.new(body: params[:comment])
    @comment_memo_item.save

    @comment_metadata = nil
    comment_metadata_str = params[:comment_metadata]
    if !comment_metadata_str.nil?
      comment_metadata_items = comment_metadata_str.split(',')
      comment_metadata_items.each do |item|
        item.strip!
        metadatum = Metadatum.find_or_create_by(name: item)
        @comment_memo_item.metadata << metadatum
      end
    end

    # create memo_item of title
    @title_memo_item = MemoItem.new(body: params[:title])
    @title_memo_item.save

    # create relations
    ## title
    view_context.create_relationship(@url_memo_item, @title_memo_item, '#bookmark_title')

    ## comment    title_relationship_name = RelationshipName.find_or_create_by(name: '#bookmark_title')
    view_context.create_relationship(@url_memo_item, @comment_memo_item, '#bookmark_comment')

    redirect_to @url_memo_item
  end

  def edit
    @bookmark = view_context.get_bookmark_data(params[:id])
  end

  def show
    @bookmark = view_context.get_bookmark_data(params[:id])
  end

  def destroy
    bookmark = view_context.get_bookmark_data(params[:id])
    bookmark[:url].destroy
    bookmark[:title].destroy
    bookmark[:comment].destroy
    redirect_to bookmarks_url
  end
end
