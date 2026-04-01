load "dotenv.ring"

dotenv = new dotenv()

// Ensure required variables exist in .env
// If the key is missing, a stub (KEY=) is appended to the file
// If .env doesn't exist, it is created automatically

dotenv.requiredVar("HOST")
dotenv.requiredVar("PORT")

print("Checked required variables.\n")
