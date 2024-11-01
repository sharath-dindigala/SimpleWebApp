FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/aspnet:8.0-noble-chiseled AS base
ARG TARGETARCH
USER app
WORKDIR /app
EXPOSE 8080

FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
ARG TARGETARCH
WORKDIR /src
COPY ["SimpleWebApp.csproj", "./"]
RUN dotnet restore -a $TARGETARCH "./SimpleWebApp.csproj"
COPY . .
RUN dotnet build -a $TARGETARCH "./SimpleWebApp.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
ARG TARGETARCH
RUN dotnet publish -a $TARGETARCH "./SimpleWebApp.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SimpleWebApp.dll"]