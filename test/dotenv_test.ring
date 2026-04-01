/*
    Test suite for the dotenv library
*/

load "../lib.ring"

// Track results
passed = 0
failed = 0
total  = 0

func main {
    env = new dotenv()

    // Basic key/value
    assert("DB_HOST",  env.getEnv("DB_HOST"),  "localhost")
    assert("DB_PORT",  env.getEnv("DB_PORT"),  "5432")
    assert("DB_NAME",  env.getEnv("DB_NAME"),  "myapp_db")
    assert("DB_USER",  env.getEnv("DB_USER"),  "admin")
    assert("APP_ENV",  env.getEnv("APP_ENV"),  "production")
    assert("APP_DEBUG", env.getEnv("APP_DEBUG"), "false")
    assert("APP_URL",  env.getEnv("APP_URL"),  "http://localhost:8080")

    // Double-quoted value (contains '=')
    assert("DB_PASS (quoted, with =)",
	    env.getEnv("DB_PASS"),
	    "s3cr3t=value=with=equals")

    // Single-quoted value
    assert("APP_NAME (single-quoted)",
	    env.getEnv("APP_NAME"),
	    "My Application")

    // Variable interpolation
    assert("DB_CONNECTION_STRING (interpolation)",
	    env.getEnv("DB_CONNECTION_STRING"),
	    "postgres://admin:s3cr3t=value=with=equals@localhost:5432/myapp_db")

    // Inline comments
    assert("SECRET_KEY (inline comment stripped)",
	    env.getEnv("SECRET_KEY"),
	    "abcdef123456")

    assert("QUOTED_WITH_COMMENT (inline comment, quoted)",
	    env.getEnv("QUOTED_WITH_COMMENT"),
	    "hello world")

    // Empty value
    assert("EMPTY_VALUE",
	    env.getEnv("EMPTY_VALUE"),
	    "")

    // Unquoted multi-word value
    assert("NO_QUOTES",
	    env.getEnv("NO_QUOTES"),
	    "simple value here")

    // Whitespace around '='
    assert("SPACES_AROUND (trimmed)",
	    env.getEnv("SPACES_AROUND"),
	    "spaces trimmed")

    // export prefix
    assert("EXPORTED_VAR (export prefix)",
	    env.getEnv("EXPORTED_VAR"),
	    "i_was_exported")

    // Multiple '=' in value
    assert("MULTI_EQUALS",
	    env.getEnv("MULTI_EQUALS"),
	    "a=b=c=d")

    // Missing key returns NULL
    assert("MISSING_KEY (NULL)",
	    env.getEnv("MISSING_KEY"),
	    NULL)

    // getEnvOr fallback
    assert("getEnvOr (existing key)",
	    env.getEnvOr("DB_HOST", "fallback"),
	    "localhost")

    assert("getEnvOr (missing key, fallback)",
	    env.getEnvOr("NONEXISTENT", "my_default"),
	    "my_default")

    // hasKey
    assert("hasKey (DB_HOST)",
	    env.hasKey("DB_HOST"),
	    true)

    assert("hasKey (NONEXISTENT)",
	    env.hasKey("NONEXISTENT"),
	    false)

    // getAll returns a list
    all = env.getAll()
    assert("getAll is list",  isList(all),  true)
    assert("getAll not empty", len(all) > 0, true)

    // setEnvVars / sysget
    env.setEnvVars()
    assert("sysget(DB_HOST) after setEnvVars",
	    sysget("DB_HOST"),
	    "localhost")

    assert("sysget(APP_ENV) after setEnvVars",
	    sysget("APP_ENV"),
	    "production")

    // unsetEnvVars / sysget
    env.unsetEnvVars()
    assert("sysget(DB_HOST) after unsetEnvVars",
	    sysget("DB_HOST"),
	    "")

    // loadFile with custom path
    env2 = new dotenv
    env2.loadFile(".env")
    assert("loadFile(.env) DB_HOST",
	    env2.getEnv("DB_HOST"),
	    "localhost")

    // loadFile with non-existent file raises error
    errorCaught = false
    try {
		env3 = new dotenv
		env3.loadFile("nonexistent.env")
    catch
		errorCaught = true
    }
    assert("loadFile non-existent raises error",
	    errorCaught,
	    true)

    // Print summary
    see nl + "=================================" + nl
    see "  PASSED: " + passed + " / " + total + nl
    if (failed > 0) {
		see "  FAILED: " + failed + " / " + total + nl
    }
    see "=================================" + nl
}

// Helper
func assert(name, actual, expected) {
    total++
    if (actual = expected) {
		passed++
		see "  ✓ " + name + nl
    else
		failed++
		see "  ✗ " + name + nl
		see "      expected: [" + toDisplayStr(expected) + "]" + nl
		see "      actual:   [" + toDisplayStr(actual)   + "]" + nl
    }
}

func toDisplayStr(val) {
    if (isNull(val)) {
		return "NULL"
    }
    if (isString(val)) {
		return val
    }
    if (isNumber(val)) {
		if (val = true)  { return "true"  }
		if (val = false) { return "false" }
		return "" + val
    }
    return "(unknown)"
}
