require 'csv'

csv_path = File.join(Rails.root, 'db', 'booklist.csv')
CSV.foreach(csv_path, :headers => true) do |row|
   book = Book.create!(
      :title => row['Title'],
      :description => row['Description'],
      :author => row['Author'],
      :category_id => row['Category ID'].to_i,
      :image_file_name => 'classof1940.jpg',
      :price => row['Price'],
      :shipping => row['Shipping'],
      :paypal_link => row['Paypal Link']
   )
   book.save
end
