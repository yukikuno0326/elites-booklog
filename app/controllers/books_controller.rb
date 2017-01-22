class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    if user_signed_in? && params[:ft] && params[:ft] == 'my'
      @books = Book.includes(:bookmarks, :reviews, :user).where(user_id: current_user.id).category_filter(params[:filter_category_id]).order('updated_at DESC')
    elsif user_signed_in? && params[:ft] && params[:ft] == 'bookmark'
      @books = Book.joins(:bookmarks).where('bookmarks.user_id = ?', current_user.id).category_filter(params[:filter_category_id]).order('updated_at DESC')
    else
      @books = Book.includes(:bookmarks, :reviews, :user).category_filter(params[:filter_category_id]).order('updated_at DESC')
    end
    @categories = Category.all
  end
  
  def show
    @book = Book.find(params[:id])
    if user_signed_in?
      @my_bookmark = @book.bookmarks.select{|s| s.user_id == current_user.id}.first
    end
    if user_signed_in?
      my_review = @book.reviews.select{|s| s.user_id == current_user.id}.first
      unless my_review
        @my_review = Review.new
      end
    end
  end
  
  def new
    @book = Book.new
    @category = Category.all
  end
  
  def create
    @book = Book.new
    @book.attributes = input_params
    @book.user_id = current_user.id
    if @book.valid?
      @book.save!
      flash[:notice] = I18n.t('book.created')
      redirect_to action: :show, id: @book.id
    else
      render :new
    end
  end
  
  def edit
    @book = Book.find(params[:id])
    @category = Category.all
  end
  
  def update
    @book = Book.find(params[:id])
    @book.attributes = input_params
    @book.user_id = current_user.id
    if @book.valid?
      @book.save!
      flash[:notice] = I18n.t('book.updated')
      redirect_to action: :show
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy!
    flash[:notice] = I18n.t('book.deleted')
    redirect_to action: :index
  end
  
  def filter_by_category 
    if params[:filter_category_id].present?
      redirect_to action: :index, filter_category_id: params[:filter_category_id]
    else
      redirect_to action: :index
    end
  end
  

  private
  def input_params
    params.require(:book).permit(:title, :author, :publisher, :price, :publish_date, :caption, :image, :category_id)
  end
  
end
