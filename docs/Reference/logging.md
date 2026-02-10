# Logging

# Introduction
 Microservices logging uses the Winston logging format. Log levels for both MPS and RPS microservices are controlled by the environmental variables MPS_LOG_LEVEL and RPS_LOG_LEVEL respectively. Logging levels are listed in the table below by increasing level of detail: `error`, `warn`, `info`, `verbose`, `debug`, and `silly`.

# Log levels

| Log level     | Description |
| :------------------------- | :-- |
| error            | only critical errors such as exceptions; 500 level api responses |
| warn             | unexpected issue which don't affect service operation |
| info             | service startup and shutdown messages (default level for MPS and RPS services) |
| verbose          | database query messages; device heartbeat; 200 level api responses |
| debug            | level useful for diagnosing issues with the services; 400 level api responses|
| silly            | all logs|

## Setting Log Levels

Set the log levels in the `.env` file by altering the configuration levels, `MPS_LOG_LEVEL` and `RPS_LOG_LEVEL`. Find the log level descriptions in the tables contained in [MPS Configuration](./MPS/configuration.md) and [RPS Configuration](./RPS/configuration.md).

## Docker Logs

Each microservice has an associated log file which can contain helpful debug information. Use `docker logs` to print log information to the terminal.

**To run docker log files in a terminal window as needed:**

1. Open a Terminal or Powershell/Command Prompt and run the command to list the containers:

    ``` bash
    docker ps
    ```

2. Copy the first three digits of the container ID of interest. Run the docker logs command followed by the container ID:

    ``` bash
    docker logs <container ID>
    ```

See more help options for the `docker logs` command in [Docker Documentation](https://docs.docker.com/engine/reference/commandline/logs/).