# Book
`has_many Reviews`
`has_many Book_Authors`
`has_many Authors, through Book_Authors`
- Pages
- Year
- cover

# Book_Author
`belongs_to Book` <book_id>
`belongs_to Author`<author_id>


# Author
`has_many Book_Authors`
`has_many Books, through Book_Authors`
`it { should have_many(:books).through :book_authors}`
- Name

# User
`has_many Reviews`
- Name

# Review
`belongs_to Book` <book_id>
`belongs_to User` <user_id> -- or just "user"
- Title
- Text
- Rating
- User
