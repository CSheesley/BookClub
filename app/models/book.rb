class Book < ApplicationRecord
  validate_presence_of :title
  validate_presence_of :pages
  validate_presence_of :year
  validate_presence_of :cover

  
end
