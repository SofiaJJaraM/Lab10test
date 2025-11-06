admin = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :admin
end

author = User.find_or_create_by!(email: "author@example.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :regular
end

# Sample recipes
Recipe.create!([
  {
    title: "Spaghetti Bolognese",
    cook_time: 45,
    difficulty: "Fácil",
    user: author
  },
  {
    title: "Risotto de Champiñones",
    cook_time: 40,
    difficulty: "Media",
    user: author
  },
  {
    title: "Pollo al Curry",
    cook_time: 50,
    difficulty: "Media",
    user: author
  },
  {
    title: "Tarta de Manzana",
    cook_time: 60,
    difficulty: "Difícil",
    user: admin
  },
  {
    title: "Ensalada César",
    cook_time: 15,
    difficulty: "Fácil",
    user: admin
  }
])