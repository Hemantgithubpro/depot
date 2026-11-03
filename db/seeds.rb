# db/seeds.rb

# 1. Clean up dependent child records to satisfy foreign key constraints
LineItem.delete_all
Order.delete_all
Cart.delete_all

# 2. Reset products and users
Product.delete_all
User.delete_all

# 3. Create initial administrator
User.create!(
  email_address: "admin@example.com",
  password: "password"
)

# 4. Build product in memory (Product.new does not validate or save yet)
product = Product.new(
  title: 'Rails Scales!',
  description: %(<p>
    <em>Practical Techniques for Performance and Growth</em>
    Rails doesn't scale. So say the naysayers. They're wrong. Ruby on Rails
    runs some of the biggest sites in the world, impacting the lives of
    millions of users while efficiently crunching petabytes of data. This
    book reveals how they do it, and how you can apply the same techniques
    to your applications. Optimize everything necessary to make an
    application function at scale: monitoring, product design, Ruby code,
    software architecture, database access, caching, and more. Even if your
    app may never have millions of users, you reduce the costs of hosting
    and maintaining it.
  </p>),
  price: 30.95
)

# 5. Attach the image
product.image.attach(
  io: File.open(Rails.root.join('db', 'images', 'cprpo.jpg')),
  filename: 'cprpo.jpg',
  content_type: 'image/jpeg'
)

# 6. Save and run validations now that the image is present
product.save!
