class BooksController < ApplicationController
  # GET /books
  # GET /books.json
  def index
    @books = Book.all
    @books_list = @books.to_json(:methods => [:cover_image_url],:only => [:name, :title, :author, :publish_date]) if @books.present?
    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        #render json: @books 
        render_json(@books_list)
      }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { 
        #render json: @book 
        render_json({:status => 200, :name => @book.name, :title => @book.title, :author => @book.author}.to_json)
      }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { 
          #render json: @book, status: :created, location: @book 
          render_json({:status => 200, :message => "successfully created #{@book.name} book"}.to_json)
        }
      else
        format.html { render action: "new" }
        format.json { 
          #render json: @book.errors, status: :unprocessable_entity
          render_json({:errors => @book.display_errors, :status => 404}.to_json)
        }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  def get_page_content
    @book = Book.find(params[:book_id])
    @page_content = @book.pages.to_json(:only => [:content]) if @book.present?
    render_json(@page_content)
  end

  def get_page_wise_content
    @book = Book.find(params[:book_id])
    @pages = @book.pages.where(:page_number => params[:to]..params[:from]).order("page_number ASC")
    @page_content = @pages.to_json(:only => [:content, :page_number]) if @pages.present?
    render_json(@page_content)
  end
end
