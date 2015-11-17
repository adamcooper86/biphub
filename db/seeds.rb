#create the admin user

Admin.create(email: "admin@biphub.com", first_name: "Admin", last_name: "istrator", password: "abc123", password_confirmation: "abc123")
School.create(name: "Beverly Hills High", address: "123 TVLand Dr.", city: "Beverly Hills", state: "CA", zip: "90210")
Coordinator.create(email: "coordinator@biphub.com", first_name: "Cory", last_name: "Nader", password: "abc123", password_confirmation: "abc123")
Speducator.create(email: "patch.adams@biphub.com", first_name: "Patch", last_name: "Adams", password: "abc123", password_confirmation: "abc123")
