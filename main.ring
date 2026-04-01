load "lib.ring"

func main() {
	print('** dotenv - A zero-dependency .env file parser for Ring **

Features:
  - Auto-load .env on instantiation
  - export prefix, inline comments, quoted values
  - Variable interpolation (${VAR})

Quick Start:

  load "dotenv.ring"

  dotenv = new dotenv()          // auto-loads .env
  username = dotenv.getEnv("USERNAME")
  print(username)

API:
  loadDefault()       Load the default .env file
  loadFile(path)      Load a custom env file
  getEnv(key)         Get a variable (NULL if missing)
  getEnvOr(key, def)  Get a variable with a fallback
  hasKey(key)         Check if a key was loaded
  getAll()            Return all loaded key-value pairs
  setEnvVars()        Push vars into the system environment
  unsetEnvVars()      Remove vars from the system environment
  requiredVar(name)   Append a stub to .env if missing

See examples/ for runnable samples.
')
}
