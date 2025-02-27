# IP Changer Script

## Overview

The IP Changer script is a Bash script designed to change your IP address anonymously using the Tor network. It can be run as a service on Linux systems, allowing users to frequently change their IP address for enhanced privacy and security.

## Features

- Installs and manages the Tor service.
- Changes the IP address at regular intervals.
- Provides a simple command-line interface to start, stop, and restart the service.
- Automatically installs Tor if it is not already present on the system.

## Prerequisites

- A Linux-based operating system.
- Root privileges to install packages and manage services.

## Installation

3. **Run the Script**:

   ```bash
   curl -O https://raw.githubusercontent.com/h4shell/ipchanger_tor/refs/heads/main/install.sh | sudo bash install.sh
   ```

   The script will install itself to `/etc/init.d/ipchanger` if it is not already installed.

## Usage

Once the script is installed, you can manage the IP Changer service using the following commands:

- **Start the Service**:

  ```bash
  sudo /etc/init.d/ipchanger start
  ```

- **Stop the Service**:

  ```bash
  sudo /etc/init.d/ipchanger stop
  ```

- **Restart the Service**:
  ```bash
  sudo /etc/init.d/ipchanger restart
  ```

## How It Works

1. **Root Check**: The script checks if it is being run with root privileges. If not, it prompts the user to run it with `sudo`.

2. **Script Installation**: If the script is not already installed, it copies itself to `/etc/init.d/ipchanger` and makes it executable.

3. **Service Management**:
   - **Start**:
     - Checks if Tor is installed; if not, it installs Tor.
     - Starts the Tor service if it is not already running.
     - Enters an infinite loop where it reloads the Tor service to change the IP address and prints the new IP every second.
   - **Stop**:
     - Stops the service by killing the background process and removing the PID file.

## Dependencies

- `tor`: The Tor service must be installed for the script to function correctly.
- `curl`: Used to fetch the current IP address.

## Important Notes

- Running this script will frequently change your IP address, which may affect your internet connectivity and the ability to access certain services.
- Ensure that you comply with all applicable laws and regulations regarding the use of Tor and IP changing.

## Troubleshooting

- If you encounter issues with the script, ensure that you have the necessary permissions and that the Tor service is functioning correctly.
- Check the system logs for any errors related to the Tor service.

## License

This script is released under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or feature requests.

## Contact

For any questions or feedback, please contact the author at [h4shell@mail.com].

---

This README provides a comprehensive overview of the IP Changer script, including installation instructions, usage, and important notes. Feel free to modify the contact information and any other sections as needed.
