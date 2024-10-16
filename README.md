# super-service
## Part-1
Pre-requisites:

1) Ensure Docker Desktop or Docker Engine is installed on your machine.
2) Install the .NET Framework 3.1.0 on your machine.

Deployment instructions:

1) Clone the source code: `git clone https://github.com/arjunvalayanal95/super-service.git`
2) Execute `Deploy.ps1`

- The script will first execute unit tests. If any test fails, an error will be displayed, and the process will halt. If the tests pass, the build process will proceed.
- In case the Docker build fails, the script will terminate. Otherwise, it will continue to the next phase.
- The Docker image will then be scanned for vulnerabilities using `Docker Scout`, with any detected issues reported as warnings.
- The containerized application will be deployed locally as the final step.

## Part-2
