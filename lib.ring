/*
    dotenv
    A .env file parser and manipulation library.

    Copyright (c) 2024-2026 Youssef Saeed
    GitHub: https://github.com/ysdragon
    License: MIT
*/

load "stdlibcore.ring"

class dotenv {

	envVars     = []
	defaultFile = ".env"
	isLoaded    = false

	// Auto-load .env on instantiation
	func init() {
		if (fexists(defaultFile)) {
			loadFile(defaultFile)
		}
	}

	// Load .env as the default file (backward compatible)
	func loadDefault() {
		if (fexists(defaultFile)) {
			return loadFile(defaultFile)
		else
			raise("dotenv: '" + defaultFile + "' not found")
		}
	}

	// Load and parse a specific env file
	func loadFile(fileName) {
		if (!fexists(fileName)) {
			raise("dotenv: file '" + fileName + "' not found")
		}

		// Reset state for a clean reload
		self.envVars = []

		fileContent = read(fileName)

		// Normalise line endings (\r\n → \n, stray \r → "")
		fileContent = substr(fileContent, char(13), "")
		lines = split(fileContent, char(10))

		for line in lines {
			line = trim(line)

			// Skip empty lines and comments
			if (line = "" or left(line, 1) = "#") { loop }

			// Strip optional 'export ' prefix
			if (len(line) > 7 and left(line, 7) = "export ") {
				line = trim(substr(line, 8, len(line) - 7))
			}

			// Split on the first '=' so values may contain '='
			eqPos = substr(line, "=")
			if (eqPos = 0) {loop }

			// Extract key
			key = trim(left(line, eqPos - 1))
			if (key = "") { loop }

			// Extract value (everything after the first '=')
			if (eqPos < len(line)) {
				value = substr(line, eqPos + 1, len(line) - eqPos)
			else
				value = ""
			}

			// Clean and process the value
			value = trim(value)
			value = stripInlineComment(value)
			value = stripQuotes(value)
			value = interpolate(value)

			// Store key-value pair
			envVars[key] = value
		}

		isLoaded = true
		return envVars
	}

	// Get a variable (returns NULL when missing)
	func getEnv(key) {
		return getEnvOr(key, NULL)
	}

	// Get a variable with an explicit fallback
	func getEnvOr(key, defaultValue) {
		if (hasKey(key)) {
			return envVars[key]
		}
		return defaultValue
	}

	// Check whether a key has been loaded
	func hasKey(key) {
		for item in envVars {
			if (item[1] = key) { return true }
		}
		return false
	}

	// Return every loaded variable
	func getAll() {
		return envVars
	}

	// Push all loaded variables into the system environment
	func setEnvVars() {
		for item in envVars {
			sysset(item[1], item[2])
		}
	}

	// Remove all loaded variables from the system environment
	func unsetEnvVars() {
		for item in envVars {
			sysunset(item[1])
		}
	}

	// Append a variable stub to the default file if it is missing
	func requiredVar(varName) {
		if (fexists(defaultFile)) {
			if (!isLoaded) { loadFile(defaultFile) }
			if (hasKey(varName)) { return }
		}

		content = ""
		if (fexists(defaultFile)) {
			content = read(defaultFile)
		}

		// Ensure we start on a new line if the file doesn't end with one
		if (content != "" and right(content, 1) != char(10)) {
			entry = char(10) + varName + "="
		else
			entry = varName + "="
		}

		// Append the missing variable stub
		fp = fopen(defaultFile, "a")
		fwrite(fp, entry)
		fclose(fp)
	}

	/*** Private helpers ***/

	private

	// Strip an inline comment while respecting quoted values
	func stripInlineComment(value) {
		if (value = "") { return value }

		fc = left(value, 1)

		// Quoted value – find the matching close-quote and discard the rest
		if (fc = '"' or fc = "'") {
			for i = 2 to len(value) {
				if (substr(value, i, 1) = fc) {
					return left(value, i)
				}
			}
			return value
		}

		// Unquoted value – cut at the first ' #'
		hPos = substr(value, " #")
		if (hPos > 0) {
			return trim(left(value, hPos - 1))
		}
		return value
	}

	// Remove matching surrounding quotes
	func stripQuotes(value) {
		if (len(value) < 2) { return value }

		fc = left(value, 1)
		lc = right(value, 1)

		if ((fc = '"' and lc = '"') or (fc = "'" and lc = "'")) {
			if (len(value) = 2) { return "" }
			return substr(value, 2, len(value) - 2)
		}
		return value
	}

	// Resolve ${VAR} references against already-loaded variables
	func interpolate(value) {
		result = value

		while(true) {
			// Find the start of a variable reference
			sPos = substr(result, "${")
			if (sPos = 0) { exit }

			// Extract everything after '${'
			remaining = substr(result, sPos + 2, len(result) - sPos - 1)

			// Find the closing '}'
			ePos = substr(remaining, "}")
			if (ePos = 0) { exit }

			// Get the variable name and its replacement value
			varName     = left(remaining, ePos - 1)
			replacement = ""
			if (hasKey(varName)) {
				replacement = envVars[varName]
			}

			// Rebuild the string with the resolved value
			before = ""
			if (sPos > 1) {
				before = left(result, sPos - 1)
			}

			afterPos = sPos + 2 + ePos
			after    = ""
			if (afterPos <= len(result)) {
				after = substr(result, afterPos, len(result) - afterPos + 1)
			}

			result = before + replacement + after
		}

		return result
	}
}
