#Using Official .NET Docker image
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build

#Setting the Work Directory
WORKDIR /super-svc

#Copy csproj and restore dependencies
COPY ./src/*.csproj .
RUN dotnet restore

#Copying the source-code and building
COPY ./src .
RUN dotnet publish -c Release -o /super-svc/publish

#Using official runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1

#Setting the Work Directory
WORKDIR /super-svc

#Copying from build stage
COPY --from=build /super-svc/publish /super-svc/

#Exposing the port
EXPOSE 80

#Run the application
ENTRYPOINT ["dotnet", "SuperService.dll"]
