load "dotenv.ring"

dotenv = new dotenv()

// Load a custom .env file instead of the default
dotenv.loadFile(".env.example")

username = dotenv.getEnv("USERNAME")
password = dotenv.getEnv("PASSWORD")
state = dotenv.getEnv("STATE")

print("Username: #{username}\n")
print("Password: #{password}\n")
print("State:    #{state}\n")
