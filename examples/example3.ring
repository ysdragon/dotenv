load "dotenv.ring"

dotenv = new dotenv()

// Push all loaded variables into the system environment
print("--- setting env vars ---\n")
dotenv.setEnvVars()

print("USERNAME: #{sysget("USERNAME")}\n")
print("PASSWORD: #{sysget("PASSWORD")}\n")
print("STATE:    #{sysget("STATE")}\n")

// Remove them from the system environment
print("--- unsetting env vars ---\n")
dotenv.unsetEnvVars()

print("USERNAME: #{sysget("USERNAME")}\n")
print("PASSWORD: #{sysget("PASSWORD")}\n")
print("STATE:    #{sysget("STATE")}\n")
