class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def destroy
    author = Author.find(params[:id])
    books =  author.books
    reviews = books.map{|b| b.reviews}.flatten
    reviews.each{|review| review.destroy}
    Book.destroy(books.ids)
    authors_to_delete = Author.all.select{|a| a.books.empty?}
    authors_to_delete.each{|author| author.destroy}


    redirect_to books_path
  end
end
