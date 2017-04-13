# GitHub Issues to VersionOne Sync
This project aims to provide clarity into organization owned open source projects where issues are tracked within the community via GitHub Issues by synchronizing these issues with the organization's VersionOne instance.

## Getting Started

1. Create a webhook for your organization within GitHub
  - use the address of the soon-to-be deployed instance; example: `http://mywebhooks.com/hooks/github`
  - remember the **SECRET**
1. Appropriately modify the [GitHub configuration file](./src/server/github.json) with desired repositories and their configurations
1. Create an [.env file](environment-variables) with appropriate values
1. Run `yarn run build` to create docker container named: `versionone-github-issue-sync`
1. Connect to docker-machine host and run docker container; providing the environment file: `docker run -d -p 80:4657 --env-file .env versionone-github-issue-sync:latest`
  - **gotcha**: ensure the mapped port (3001 in the example above) is the same as the one in your environment file

## Contributing
### Running Locally
1. Sign-up and download [ngrok](https://ngrok.com/)
1. Set your authentication token for ngrok via `ngrok authtoken my-auth-token`
1. Run ngrok via `ngrok http 4657`
1. Grab the output ngrok address and create a GitHub webhook; specifiying the URL with the ngrok address and the proper path of `/hooks/github`; e.g. `http://ngrok/hooks/github`
1. Run `yarn start`. Ensure appropriate [environment variables](#environment-variables) are set when running this command; specifically the **GITHUB_SECRET** (from the above step).

## Environment Variables
- GITHUB_SECRET: organization webhook secret
- PORT: the port in which the server will listen; defaults to 4657
