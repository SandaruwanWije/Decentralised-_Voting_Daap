FROM mcr.microsoft.com/dotnet/core/aspnet:2.1-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.1-stretch AS build
WORKDIR /src
COPY ["DecentralizedVotingApplication/DecentralizedVotingApplication.csproj", "DecentralizedVotingApplication/"]
RUN dotnet restore "DecentralizedVotingApplication/DecentralizedVotingApplication.csproj"
COPY . .
WORKDIR "/src/DecentralizedVotingApplication"
RUN dotnet build "DecentralizedVotingApplication.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "DecentralizedVotingApplication.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DecentralizedVotingApplication.dll"]