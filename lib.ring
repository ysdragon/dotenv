/*
    Author: ysdragon (https://github.com/ysdragon)
*/

load "stdlibcore.ring"

class dotenv {

    envVars = [] 
    defaultFile = ".env"

    // Function to load .env as the default file
    func loadDefault() {
        if (fexists(defaultFile)) {
            return loadFile(".env")
        else
            print("Error: #{defaultFile} doesn't exist!")
            bye
        }
    }

    // Function to parse custom env file
    func loadFile(fileName) {
        // Check if fileName exists
        if(fexists(fileName)) {
            fileContent = read(fileName)
        else 
            print("Error: #{fileName} doesn't exist!")
            bye

        }
        // Split the content into lines
        lines = split(fileContent, "\n")
        // Loop through each line
        for line in lines {
            // Remove leading and trailing whitespace
            line = trim(line) 
            // Ignore empty lines and comments
            if (line != "" and not startsWith(line, "#")) { 
                // Split the line into key and value
                parts = split(line, "=") 

                if (len(parts) < 2) {
                    // Skip to the next line
                    continue 
                }
                // Get the key
                key = trim(parts[1])
                // Get the value
                value = trim(parts[2]) 
                // Store in the list
                envVars[key] = value
            }
        }
        // Return the list of environment variables
        return envVars 
    }

    // Function to get specific env variable value
    func getEnv(key) {
        // Get the value directly
        value = envVars[key] 
        // Check if the value is not empty
        if (value != NULL) {
            // Return the found value
            return value
        }
    }

    // Function to set envVars to environment (useful for docker compose, etc)
    func setEnvVars() {
        if(len(envVars) != 0) {
            for var in envVars {
                sysset(var[1], var[2])
            }
        }
    }

    // Function to unset envVars from environment
    func unsetEnvVars() {
        if(len(envVars) != 0) {
            for var in envVars {
                sysunset(var[1])
            }
        }
    }
}