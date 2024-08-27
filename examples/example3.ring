load "dotenv.ring"

dotenv = new dotenv

// Load default .env file
dotenv.loadDefault()

// Set env vars from the .env file
print("############# set\n")
dotenv.setEnvVars()

print("############# get\n")
print(sysget("USERNAME") + "\n")
print(sysget("PASSWORD") + "\n")
print(sysget("USERNAME") + "\n")

// Unset env vars from the .env file
print("############# unset\n")
dotenv.unsetEnvVars()

print("############# get\n")
print(sysget("USERNAME"))
print(sysget("PASSWORD"))
print(sysget("USERNAME"))