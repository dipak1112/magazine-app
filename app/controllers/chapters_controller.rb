class ChaptersController < ApplicationController
  before_filter :find_book, :only => [:new, :create, :show, :edit, :update, :index, :destroy]
  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = @book.chapters
    @chapter_list = @chapters.to_json(:only => [:name, :chapter_start, :chapter_end]) if @chapters.present?
    respond_to do |format|
      format.html
      format.json { 
        render_json(@chapter_list)
      }
    end
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chapter }
    end
  end

  # GET /chapters/new
  # GET /chapters/new.json
  def new
    @chapter = @book.chapters.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chapter }
    end
  end

  # GET /chapters/1/edit
  def edit
    @chapter = Chapter.find(params[:id])
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = @book.chapters.build(params[:chapter])
    @chapter.book_id = params[:book_id]
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to book_chapter_path(@book,@chapter), notice: 'Chapter was successfully created.' }
        format.json { render json: @chapter, status: :created, location: @chapter }
      else
        format.html { render action: "new" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chapters/1
  # PUT /chapters/1.json
  def update
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        format.html { redirect_to book_chapter_path(@book,@chapter), notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter = Chapter.find(params[:id])
    @chapter.destroy

    respond_to do |format|
      format.html { redirect_to book_chapters_url(@book) }
      format.json { head :no_content }
    end
  end

  private
    def find_book
      @book = Book.find(params[:book_id])
    end

end
