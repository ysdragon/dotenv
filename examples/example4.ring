load "dotenv.ring"

dotenv = new dotenv()

// Load a custom file and push its variables into the system environment
dotenv.loadFile(".env.example")

print("--- setting env vars from .env.example ---\n")
dotenv.setEnvVars()

print("USERNAME: #{sysget("USERNAME")}\n")
print("PASSWORD: #{sysget("PASSWORD")}\n")
print("STATE:    #{sysget("STATE")}\n")

print("--- unsetting env vars ---\n")
dotenv.unsetEnvVars()

print("USERNAME: #{sysget("USERNAME")}\n")
print("PASSWORD: #{sysget("PASSWORD")}\n")
print("STATE:    #{sysget("STATE")}\n")