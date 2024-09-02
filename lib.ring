/*
    Author: ysdragon (https://github.com/ysdragon)
*/

load "stdlibcore.ring"

class dotenv {

    envVars = [] 
    defaultFile = ".env"

    // Function to load .env as the default file
    func loadDefault() {
        if(fexists(defaultFile)) {
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
            if(line != "" and not startsWith(line, "#")) { 
                // Split the line into key and value
                parts = split(line, "=") 
                // Get the key
                key = trim(parts[1])
                // Initialize value as empty string
                value = ""
                // If there are more than 2 parts, append the remaining parts as the value
                if(len(parts) > 2) {
                    value = parts[2] + "="
                elseif (len(parts) = 2)
                    value = "" 
                }
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
        if(value != NULL) {
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
        // If envVars != 0 then run a loop on every var in envVars to unset
        if(len(envVars) != 0) {
            for var in envVars {
                sysunset(var[1])
            }
        }
    }
}