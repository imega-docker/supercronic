# Supercronic in docker

## Overview

Docker image contains supercronic is a powerful, lightweight tool designed
to manage your services and xh is a modern command-line HTTP client inspired
by `curl`. It can be integrated seamlessly into your workflow to ensure that
scheduled tasks are executed reliably.

## Features

-   **HTTP Protocol Management**: It uses the HTTP protocol to manage services,
    making it compatible with a wide range of web services and APIs.
-   **Lightweight and Efficient**: Designed to be lightweight, it minimizes
    resource usage while ensuring efficient task execution.
-   **Seamless Integration**: Integrates smoothly into existing workflows and
    can be easily configured to manage various tasks.

## Requirements

-   Docker installed on your system.

## Installation

```bash
$ docker pull imega/supercronic
```

## Usage

### Configuration

Supercronic uses a configuration file to define the tasks and their schedules.
Below is an example configuration file (`crontab`) for Supercronic:

```cron
# Example crontab file for Supercronic

# Run a GET request every hour
0 * * * * xh GET http://example.com/api/task

# Run a POST request every day at midnight
0 0 * * * xh POST http://example.com/api/task2 key1=value1 key2=value2
```

### Running Supercronic

To start Supercronic with your configuration file, use the following command:

```bash
$ docker run --rm -d -v `pwd`/crontabs:/crontabs imega/supercronic -json /crontabs
```

### Example Tasks

#### Validate config

To validate a wrong config in example.

```bash
$ echo "*/1 * * *ERROR xh http://host.docker.internal:8081" > crontabs
$ docker run --rm -t -v `pwd`/crontabs:/crontabs imega/supercronic -test /crontabs
$ echo $?
```

#### GET Request

To schedule a GET request to be sent every hour:

```cron
0 * * * * xh GET http://example.com/api/task
```

#### POST Request

To schedule a POST request to be sent every day at midnight:

```cron
0 0 * * * xh POST http://example.com/api/task2 key1=value1 key2=value2
```

#### Timezone

Set timezone via ENV.

```bash
$ docker run --rm -d -e TZ=Europe/Berlin \
    -v `pwd`/crontabs:/crontabs \
    imega/supercronic -json /crontabs
```

Set timezone via config.

```bash
$ echo "CRON_TZ=Europe/Berlin" > crontabs
$ echo "*/1 * * * * xh http://someservice:8081/task" >> crontabs
$ docker run --rm -d \
    -v `pwd`/crontabs:/crontabs \
    imega/supercronic -json /crontabs
```

## Advanced Configuration

Supercronic supports advanced configurations, including environment variables
and error handling. Refer to the
[Supercronic documentation](https://github.com/aptible/supercronic) for more
detailed information.

xh supports a lot powerful configurations like formatting output and checking
statuses. Refer the [xh documentation](https://github.com/ducaale/xh)
for more detailed information.

## Troubleshooting

## Conclusion

Supercronic, combined with the `xh` HTTP client, provides a robust solution
for managing and scheduling tasks via HTTP. By following this documentation,
you should be able to set up and configure Supercronic to handle your service
management needs efficiently. For further assistance, refer to the
[official Supercronic GitHub repository](https://github.com/aptible/supercronic)
and the [xh documentation](https://github.com/ducaale/xh).

## Usage like service

```bash
$ echo "*/1 * * * * xh http://someservice:8081/task" > crontabs
$ docker run --rm -d -v `pwd`/crontabs:/crontabs imega/supercronic -json /crontabs
```
