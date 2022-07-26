# FROM mcr.microsoft.com/dotnet/core/sdk AS build
# WORKDIR /app

# COPY *.csproj ./
# RUN dotnet restore

# COPY . ./
# RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet
WORKDIR /app
COPY out/ .
ENTRYPOINT [ "dotnet", "DotNetWeb.dll" ] 