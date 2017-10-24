module UsersHelper
  # Return the class for the row based on the number passed.
  def row_class(row_number)
    (row_number % 2) == 0 ? 'odd_row' : 'even_row'
  end
end
