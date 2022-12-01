# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/dotnet/sdk:6.0 as build-env

# Change Directory
WORKDIR /src

# Source to destination
COPY src/*.csproj .

RUN dotnet restore

COPY src .

RUN dotnet publish -c Release -o /publish 

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as runtime
WORKDIR /app
COPY --from=build-env /publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "myWebApp.dll"]