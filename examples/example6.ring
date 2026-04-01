load "dotenv.ring"

dotenv = new dotenv()

// Explicitly load the default .env file
dotenv.loadDefault()

// getEnvOr() - returns a fallback when the key is missing
dbHost = dotenv.getEnvOr("DB_HOST", "localhost")
print("DB_HOST: #{dbHost}\n")

// hasKey() - check whether a variable was loaded
if dotenv.hasKey("USERNAME") {
	print("USERNAME is loaded\n")
}

// getAll() - retrieve every parsed key-value pair
allVars = dotenv.getAll()
print("All variables:\n")
for item in allVars {
	print("  #{item[1]} = #{item[2]}\n")
}