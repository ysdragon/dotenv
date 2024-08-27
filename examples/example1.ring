load "dotenv.ring"

dotenv = new dotenv

// Load default .env file
dotenv.loadDefault()

username = dotenv.getEnv("USERNAME")
password = dotenv.getEnv("PASSWORD")
state = dotenv.getEnv("STATE")

print(username + "\n")
print(password + "\n")
print(state + "\n")
