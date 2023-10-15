# Array of book data with real book names and corrected relase_date
book_data = [
  { name: "To Kill a Mockingbird", relase_date: Time.now - 365.days },
  { name: "1984", relase_date: Time.now - 270.days },
  { name: "Pride and Prejudice", relase_date: Time.now - 200.days },
  { name: "The Great Gatsby", relase_date: Time.now - 150.days },
  { name: "The Catcher in the Rye", relase_date: Time.now - 90.days },
  { name: "The Hobbit", relase_date: Time.now - 365.days },
  { name: "Brave New World", relase_date: Time.now - 200.days },
  { name: "The Lord of the Rings", relase_date: Time.now - 150.days },
  { name: "War and Peace", relase_date: Time.now - 270.days },
  { name: "The Hunger Games", relase_date: Time.now - 90.days },
  { name: "The Da Vinci Code", relase_date: Time.now - 365.days },
  { name: "The Shining", relase_date: Time.now - 200.days },
  { name: "The Girl with the Dragon Tattoo", relase_date: Time.now - 150.days },
  { name: "Moby-Dick", relase_date: Time.now - 270.days },
  { name: "Frankenstein", relase_date: Time.now - 90.days },
  { name: "The Odyssey", relase_date: Time.now - 365.days },
  { name: "The Alchemist", relase_date: Time.now - 200.days },
  { name: "The Secret Garden", relase_date: Time.now - 150.days },
  { name: "The Little Prince", relase_date: Time.now - 270.days },
  { name: "Wuthering Heights", relase_date: Time.now - 90.days },
  { name: "Crime and Punishment", relase_date: Time.now - 365.days },
  { name: "Dracula", relase_date: Time.now - 200.days },
  { name: "Alice's Adventures in Wonderland", relase_date: Time.now - 150.days },
  { name: "The Road", relase_date: Time.now - 270.days },
  { name: "Gone with the Wind", relase_date: Time.now - 90.days },
  { name: "A Tale of Two Cities", relase_date: Time.now - 365.days },
  { name: "The Count of Monte Cristo", relase_date: Time.now - 200.days },
  { name: "The Color Purple", relase_date: Time.now - 150.days },
  { name: "The Scarlet Letter", relase_date: Time.now - 270.days },
  { name: "Les Misérables", relase_date: Time.now - 365.days },
  { name: "The Picture of Dorian Gray", relase_date: Time.now - 200.days },
  { name: "One Hundred Years of Solitude", relase_date: Time.now - 150.days },
  { name: "The Hitchhiker's Guide to the Galaxy", relase_date: Time.now - 270.days },
  { name: "The Sun Also Rises", relase_date: Time.now - 90.days },
  { name: "The Brothers Karamazov", relase_date: Time.now - 365.days },
  { name: "The Metamorphosis", relase_date: Time.now - 200.days },
  { name: "The Road Less Traveled", relase_date: Time.now - 150.days },
  { name: "The Handmaid's Tale", relase_date: Time.now - 270.days },
  { name: "The Catcher in the Rye", relase_date: Time.now - 90.days }
]

# Clear the existing data from the authors and books tables
Book.destroy_all
Author.destroy_all

# Create 10 authors and have them publish the books
10.times do |i|
  author = Author.create(
    name: "Author #{i + 1}",
    email: "author#{i + 1}@example.com",
    password: "123456",
    password_confirmation: "123456"
  )

  # Assign 4 books to each author
  4.times do |j|

    author.books.create(
      name: book_data[i * j + j][:name],
      relase_date: book_data[i * j + j][:relase_date]
    )
  end
end

puts "Seed data created successfully."
