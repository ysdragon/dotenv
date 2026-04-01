<div align="center">
  <h1>dotenv</h1>

  <p>A zero-dependency .env file parser for Ring</p>

  [![Ring](https://img.shields.io/badge/Made%20with-Ring-2D54CB)](https://github.com/ring-lang/ring)
  [![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE)
</div>

## Features

- Auto-load `.env` on instantiation
- Custom file loading
- `export` prefix support
- Inline comments (respects quoted values)
- Single & double quoted values
- Variable interpolation (`${VAR}`)
- Set/unset variables in the system environment
- Required variable stubs

## Installation

```bash
ringpm install dotenv
```

## Quick Start

```ring
load "dotenv.ring"

dotenv = new dotenv()          // auto-loads .env
username = dotenv.getEnv("USERNAME")
print(username)
```

## API Reference

| Method | Description |
|--------|-------------|
| `loadDefault()` | Load the default `.env` file |
| `loadFile(path)` | Load a custom env file |
| `getEnv(key)` | Get a variable (returns `NULL` if missing) |
| `getEnvOr(key, default)` | Get a variable with a fallback |
| `hasKey(key)` | Check if a key was loaded |
| `getAll()` | Return all loaded key-value pairs |
| `setEnvVars()` | Push loaded vars into the system environment |
| `unsetEnvVars()` | Remove loaded vars from the system environment |
| `requiredVar(name)` | Append a stub to `.env` if the key is missing |

## Supported `.env` Format

```env
# Comments are ignored
export API_KEY=secret      # export prefix is stripped
QUOTED="hello world"       # quotes are removed
INLINE=value # with comment  # inline comment stripped
BASE_URL=https://api.example.com
FULL_URL=${BASE_URL}/v1    # variable interpolation
```

## Usage

### Load a custom file

```ring
dotenv = new dotenv()
dotenv.loadFile("config/.env.production")
```

### Fallback values

```ring
port = dotenv.getEnvOr("PORT", "3000")
```

### Check existence

```ring
if dotenv.hasKey("SECRET_KEY") {
    print("Secret is configured\n")
}
```

### Dump all variables

```ring
for item in dotenv.getAll() {
    print("#{item[1]} = #{item[2]}\n")
}
```

### Push to system environment

```ring
dotenv.setEnvVars()
print(sysget("USERNAME"))
dotenv.unsetEnvVars()
```

### Ensure required variables

```ring
dotenv.requiredVar("DATABASE_URL")   // appends "DATABASE_URL=" to .env if missing
```

## Examples

See the [examples](examples/) directory for runnable samples.

## License

MIT. See [LICENSE](LICENSE) for details.