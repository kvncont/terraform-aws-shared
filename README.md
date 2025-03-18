# Terraform AWS Shared Infrastructure

This repository contains the shared infrastructure for AWS, managed using Terraform. It is designed to centralize and standardize the infrastructure components that are used across multiple projects.

## Purpose

The goal of this repository is to provide reusable and consistent infrastructure modules and configurations for shared AWS resources, such as VPCs, IAM roles, S3 buckets, and more.

## Development Environment

This repository includes a development container (`devcontainer`) configuration to streamline the development process. The devcontainer provides a pre-configured environment with all necessary tools and dependencies for working with Terraform.

### Using the Devcontainer

To use the devcontainer, follow these steps:

1. **Install Prerequisites**:
   - Install [Docker](https://www.docker.com/).
   - Install [Visual Studio Code (VS Code)](https://code.visualstudio.com/).
   - Install the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension in VS Code.

2. **Open the Repository in the Devcontainer**:
   - Clone this repository to your local machine:
     ```bash
     git clone https://github.com/your-org/terraform-aws-shared.git
     ```
   - Open the repository in VS Code.
   - When prompted, click **Reopen in Container**. VS Code will build and start the devcontainer.

3. **Work Inside the Devcontainer**:
   - Once the devcontainer is running, you can use the terminal inside VS Code to run Terraform commands, such as `terraform init`, `terraform plan`, and `terraform apply`.

4. **Install Additional Tools (if needed)**:
   - If you need additional tools, you can install them inside the devcontainer. Any changes to the devcontainer configuration should be added to the `devcontainer.json` file.

## Contributing

Contributions are welcome! Please follow the standard Git workflow:
1. Fork the repository.
2. Create a feature branch.
3. Submit a pull request with your changes.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
