load "dotenv.ring"

// Create a new instance (automatically loads .env via init())
dotenv = new dotenv()

// Retrieve individual variables
username = dotenv.getEnv("USERNAME")
password = dotenv.getEnv("PASSWORD")
state = dotenv.getEnv("STATE")

print("Username: #{username}\n")
print("Password: #{password}\n")
print("State:    #{state}\n")
