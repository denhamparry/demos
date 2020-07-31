# Tutorial

> This module is focused on helping attendees learn how to use `drivein`

## Setup

### Prerequisites

Please ensure that the prerequisites are installed on your machine:

- [Docker](https://docs.docker.com/engine/install/)
- [Make](https://www.gnu.org/software/make/manual/make.html)
  - `sudo apt-get install build-essential`

### drivein

`drivein` creates a sandbox environment using a container to demonstrate coding examples.
From the tutorial directory, run the following command within a terminal shell:

```sh
$ make docker
```

You're now in the sandbox environment and can use `drivein`, run the following command within the sandbox:

```sh
$ make run-walkthrough
```

Follow the walkthrough, press `enter` to continue or `Ctrl`-`d` or `exit` to close the sandbox.
