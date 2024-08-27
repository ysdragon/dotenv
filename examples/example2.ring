load "dotenv.ring"

dotenv = new dotenv

// Load custom .env file
dotenv.loadFile(".env.example")

username = dotenv.getEnv("USERNAME")
password = dotenv.getEnv("PASSWORD")
state = dotenv.getEnv("STATE")

print(username + "\n")
print(password + "\n")
print(state + "\n")
