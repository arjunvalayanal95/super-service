$imageName = "super-service:latest"
$containerName = "super-service"
$testPath = "./test"
$dockerfilePath = "./Dockerfile"

#Run the automated tests
Write-Host "Running unit tests..."
#Set-Location ./test
dotnet test $testPath
if ($LASTEXITCODE -ne 0) {
    Write-Host "Unit tests failed. Review and fix." -ForegroundColor Red
}

# Build and package the application as a Docker image
Write-Host "Building and Packaging the Application..."
docker build -t $imageName -f $dockerfilePath .
if ($LASTEXITCODE -ne 0) {
    Write-Host "Docker build failed. Aborting!!" -ForegroundColor Red
    exit 1
}

# Use Docker Scout to scan the image
Write-Host "Scanning Image with Docker Scout..."
docker scout cves $imageName
if ($LASTEXITCODE -ne 0) {
    Write-Host "Docker Scout found vulnerabilities. Review and fix." -ForegroundColor Yellow
}

#Deploy and run the image locally
Write-Host "Deploying the Application Locally..."
docker run -d --name $containerName -p 8080:80 $imageName

docker ps

Write-Host "Deployment complete" -ForegroundColor Green
