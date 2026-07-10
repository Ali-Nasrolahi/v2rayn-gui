# v2rayN Container

A containerized Linux desktop build of **v2rayN** for Podman or Docker.

The goal of this project is to make running v2rayN inside a container as straightforward as possible while still integrating with the host desktop. Instead of installing the application directly on the host, the container runs the official Linux release and exposes its graphical interface through the host's X11/XWayland session. This allows the application to remain isolated while behaving like a regular desktop application.

The image is built directly from the official v2rayN release packages during the build process, so no application binaries are stored in this repository.

## Why?

Most Xray-based containers are designed as headless services and require managing Xray configurations manually. While that works well for automation, it is much less convenient when you want to:

* manage subscriptions
* import or export configurations
* switch profiles
* update cores
* use the familiar v2rayN interface

Running the GUI inside a container provides the same management experience while keeping the application isolated from the host operating system.

## How it works

The container executes the official Linux build of v2rayN and displays its interface using the host's graphical session.

To integrate correctly with the desktop, the container shares a few host resources:

* X11/XWayland socket
* Session D-Bus
* Xauthority
* XDG runtime directory

These allow the application to:

* display its GUI
* integrate with the KDE system tray
* communicate with desktop services

An example Compose configuration is included in this repository. It demonstrates the required environment variables, bind mounts, and desktop integration needed for a functional setup.

## Usage

Build the image yourself or pull it from Docker Hub.

Then use the provided Compose file as a starting point.

In particular, make sure to forward the appropriate desktop environment resources from the host, including:

* `DISPLAY`
* `XAUTHORITY`
* `DBUS_SESSION_BUS_ADDRESS`
* `XDG_RUNTIME_DIR`

as well as the corresponding bind mounts used by the example Compose configuration.

If you are using SELinux (for example on Fedora), ensure the bind mounts are labeled appropriately or otherwise configured for container access.

## Limitations

### Desktop responsiveness

On some systems the application may occasionally feel sluggish or briefly freeze while interacting with the UI.

This has been observed on:

* Fedora 44
* KDE Plasma (Wayland)

### Persistent data

v2rayN currently stores both application files and user data under `/opt/v2rayN`.

As a result, if you want your subscriptions, configuration, downloaded cores, and other state to persist across container recreation, you should bind mount `/opt/v2rayN` (or at least the directories containing the mutable configuration) to persistent storage.
