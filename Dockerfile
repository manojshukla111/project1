#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["PROJECT1_MANOJ/PROJECT1_MANOJ.csproj", "PROJECT1_MANOJ/"]
RUN dotnet restore "PROJECT1_MANOJ/PROJECT1_MANOJ.csproj"
COPY . .
WORKDIR "/src/PROJECT1_MANOJ"
RUN dotnet build "PROJECT1_MANOJ.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PROJECT1_MANOJ.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "PROJECT1_MANOJ.dll"]