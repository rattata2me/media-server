# Media Server

A self-hosted media server stack using Docker Compose. Includes:
- **qBittorrent** (torrent client)
- **Prowlarr** (indexer manager)
- **Radarr** (movie automation)
- **Sonarr** (TV automation)
- **Jellyfin** (media streaming)
- **Flaresolverr** (captcha resolver)

All services are networked together and use a shared data folder for media and downloads.

## Quick Start

1. **Install Docker and Docker Compose v2**
	- [Docker installation guide](https://docs.docker.com/get-docker/)
	- Compose v2 is included with recent Docker versions

2. **Clone this repository**
	```sh
	git clone https://github.com/rattata2me/media-server.git
	cd media-server
	```

3. **Configure your data folder (optional)**
	By default, all media and downloads are stored in `./data_folder`.
	To use a custom folder, set the `DATA_FOLDER` environment variable:
	```sh
	export DATA_FOLDER=/path/to/your/media
	```

4. **Start the server**
	- On Linux/macOS:
	  ```sh
	  ./media-server.sh start
	  ```
	- On Windows:
	  ```bat
	  media-server.bat start
	  ```

## Script Commands

- `start`   : Start all containers in the background
- `stop`    : Stop all running containers
- `down`    : Remove containers, keep images and volumes
- `update`  : Pull latest images and restart containers
- `clean`   : Remove containers and images, pull fresh images, restart everything

Example:
```sh
./media-server.sh clean
```

## Security Disclaimer

> **Important:**
> - The host computer should use a VPN, as this stack includes a torrent seeder (qBittorrent).
> - **Never expose this server directly to the internet** without configuring strong passwords for all services.
>   - Default credentials are `user: admin` and `password: adminadmin`.
>   - API keys are predefined and not secure by default.
> - Change all passwords and API keys before exposing any service externally.

## Customization

- Change service ports in `docker-compose.yaml` as needed.
- Set environment variables for each service for advanced configuration.
- Add or remove services by editing `docker-compose.yaml`.

## Troubleshooting

- Make sure Docker and Compose v2 are installed and working.
- If you change the data folder, set `DATA_FOLDER` before running scripts.
- For a full reset, use the `clean` command.

## License

This project is provided as-is, without warranty. Use at your own risk.
# media-server
