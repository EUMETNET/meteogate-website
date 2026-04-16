# meteogate-website
Holds the [meteogate.eu](https://www.meteogate.eu) website source code

## Overview
This repository contains the static website for MeteoGate, built with HTML, CSS, and served via Docker.

## Deployment
The website uses GitHub Actions for automated deployment.

### Development Deploy
- **Trigger**: Push to `main` branch
- **Process**:
  - Builds a Docker image using the `Dockerfile`
  - Tags the image with the short SHA and `latest`
  - Pushes to the configured image registry
- **Purpose**: Deploys development versions for testing

### Production Deploy
- **Trigger**: Push of version tags (e.g., `v1.0.0`)
- **Process**:
  - Builds a Docker image using the `Dockerfile`
  - Tags the image with the version number and `production`
  - Pushes to the configured image registry
- **Purpose**: Deploys stable production releases

## Notifications

The website displays a yellow notification bar at the top of the page. Notifications are managed via the `notifications.json` file.

### How it works
- The page fetches `notifications.json` on every page load
- Only notifications with a `validUntilUtc` date **in the future** are shown
- Expired notifications are automatically hidden (no need to remove them manually)
- Users can dismiss individual notifications with the ✕ button

### Adding a notification
1. Create a new branch
2. Edit `notifications.json` and add a new object to the array
3. Create a pull request to `main`. Changes to the JSON file are automatically validated
4. Once merged, the notification will appear after deployment

### JSON format
Each notification object supports the following fields:

| Field | Required | Description |
|-------|----------|-------------|
| `message` | ✅ Yes | The notification text |
| `validUntilUtc` | ✅ Yes | ISO 8601 UTC date (`YYYY-MM-DDTHH:MM:SSZ`). Notification is hidden after this date |
| `linkText` | No | Text for the optional link |
| `linkUrl` | No | URL for the optional link. Must start with `http://` or `https://` |

### Example

```json
[
  {
    "validUntilUtc": "2026-04-30T23:59:59Z",
    "message": "Scheduled maintenance on 2026-04-30.",
    "linkText": "Read more",
    "linkUrl": "https://eumetnet.github.io/meteogate-documentation/"
  },
  {
    "validUntilUtc": "2026-05-01T23:59:59Z",
    "message": "A simple notification without a link."
  }
]
```

### Removing a notification
Expired notifications are hidden automatically. You can either:
- **Do nothing** the notification disappears after `validUntilUtc` passes
- **Set `validUntilUtc` to a past date** which hides it immediately after deployment
- **Delete the object** from the notification array

### Validation
The `notifications.json` file is validated automatically on pull requests using `jq`. Invalid JSON will cause the lint check to fail. You can validate locally before pushing:

```bash
jq empty notifications.json
```

## Local Development
To run the website locally:
1. Clone the repository
2. Open `index.html` in a browser, or use a local server

For Docker:
```bash
docker build -t meteogate-website .
docker run -p 8080:80 meteogate-website
```
