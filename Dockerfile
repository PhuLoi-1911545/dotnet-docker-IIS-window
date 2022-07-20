#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
# RUN apt update && apt install curl -y
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
# COPY ["DotNetWeb/DotNetWeb.csproj", "DotNetWeb/"]
# my test
COPY ["DotNetWeb/DotNetWeb.csproj", "DotNetWeb/"] 


RUN dotnet restore "DotNetWeb/DotNetWeb.csproj"
COPY . .
WORKDIR "/src/DotNetWeb"
RUN dotnet build "DotNetWeb.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DotNetWeb.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DotNetWeb.dll"]