# GitHub Repository Visibility Changer

This script allows you to change the visibility of your GitHub repositories (public to private or private to public) in bulk.

## Setup

1. **Clone the repository**:
```bash
git clone https://github.com/sshd911/visibility-changer.git
cd visibility-changer
```

2. **Configure your settings**:
    - Open `config.sh` and fill in the necessary variables.
    - The default configuration is to make all public repositories private.

3. **Set your GitHub token and username an environment variables**:
    ```sh
    export GITHUB_TOKEN="your_github_token"
    export GITHUB_USERNAME="your_github_username"
    ```

## Configuration

Edit `config.sh` to set your GitHub username and token. There are also options to set the visibility type and desired state (public/private).

### config.sh

```sh
#!/bin/bash

# Fill in your GitHub username and token. It is recommended to set these as environment variables for security reasons.
GITHUB_USER="${GITHUB_USERNAME}"
GITHUB_TOKEN="${GITHUB_TOKEN}"

# Specify the visibility type of the repositories to be processed.
# Options:
# "public" - Targets public repositories.
# "private" - Targets private repositories.
REPOS_VISIBILITY_TYPE="private"

# Specify the desired visibility change for the target repositories.
# Options:
# "true" - Set repositories to private.
# "false" - Set repositories to public.
SET_TO_PRIVATE="false"
```

## Running the script
1. Make the script executable
```bash
chmod +x main.sh
chmod +x scripts/api_calls.sh
chmod +x scripts/repos_handler.sh
```

2. Run the script
```sh
./main.sh
```

This will start the process of changing the visibility of your repositories based on the configuration in config.sh.

## Troubleshooting
- Ensure your GitHub token has the necessary permissions to read and modify repository settings.
- If you encounter issues, check the output logs for error messages and open an issue.

## Contributing
If you find any bugs or have feature requests, feel free to open an issue or submit a pull request. Contributions are welcome!

