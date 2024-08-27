<div align="center">
  <h1 style="margin: auto">dotenv</h1>

  <p>An easy to use dotenv package for Ring</p>

  [![Ring](https://img.shields.io/badge/Made%20with-Ring-2D54CB)](https://github.com/ring-lang/ring)
</div>

## Features

- Read environment variables from `.env` files.
- Read environment variables from custom .env files.
- Set config variables to the environment.
- Unset config variables from the environment.

## How to install?
Using Ring Package Manager **`ringpm`**

```bash
ringpm install dotenv from ysdragon
```

## Example

```ring
load "dotenv.ring"

dotenv = new dotenv

// Load default .env file
dotenv.loadDefault()

testVar = dotenv.getEnv("USERNAME")

print(testVar)
```

#### [More examples](https://github.com/ysdragon/dotenv/tree/main/examples)

## License
This project is open-source and available under the MIT License. See the [LICENSE](https://github.com/ysdragon/dotenv/blob/master/LICENSE) file for more details.