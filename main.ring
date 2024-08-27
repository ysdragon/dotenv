# The Main File

load "lib.ring"

func main() {

	print('
	
	** An easy to use dotenv package for Ring **

	Example:

	load "dotenv.ring"

	dotenv = new dotenv

	// Load default .env file
	dotenv.loadDefault()

	testVar = dotenv.getEnv("USERNAME")

	print(testVar)

	\n')
	
}