# Demos

> Examples to use when training

## Purpose

`Demos` is attempting to lower the bar to allow people learn on their own machine.
There are great online resources, such as [Katacoda](https://katacoda.com) that teach you on their own platform.
`Demos` focuses on working with dependencies on your own machine(s) so that you can learn on your own terms.

The experience was built focusing on the user experience within a shell, and much has been learned from [Tim Hokin](https://twitter.com/thockin)'s [https://github.com/thockin/micro-demos] project.
`Demos` is based as a tool for people to present their practices to others, whilst iterating on this to provide content remotely without the need of a presentation.

## Goals

- End to end demonstrations
- Create scripts that can be re-used to test demonstrations
- Record demonstration so that dependencies are not required to follow along with demonstrations 

## Requirements

### Docker

The exercises are run within a Docker container.  This is to help prevent a range of dependencies being installed on your machine.
The image is based on Debian Buster with the core requirements to run the exercises.  It is important to run these exercises on your machine so that you can go and look around for yourself

#### Dependencies

When external binaries are required, please look to install the binary via the tool itself to help the user understand how to setup the tool itself.
To prevent having to install the binary multiple times, look to create a Docker image based off the core `.common/cli` Dockerfile.
