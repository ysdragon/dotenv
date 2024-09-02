load "dotenv.ring"

dotenv = new dotenv

// Use requiredVar to add required var(s) by your application to .env.
// And create .env file if it doesn't exist.

dotenv.requiredVar("HOST")
dotenv.requiredVar("PORT")
