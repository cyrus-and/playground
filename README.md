# playground

Disposable Docker sandbox.

## Maintenance

### Build

Rebuild the image from scratch:

```console
$ make build
```

### Update

Commit the state of an existing container to the original image and drop the container:

```console
$ make update CONTAINER=<container>
```

### Clean

Remove the image:

```console
$ make clean
```

## Usage

```console
$ make [run] [OPTIONS=<options>]
```

Where `<options>` are command line arguments passed to `docker run`. Some useful examples:

- `'OPTIONS=-p 8080:80'` to forward the container port `8080` to the host port `80`;
- `'OPTIONS=-v /container/folder:/host/folder'` to mount additional directories;
- `'OPTIONS=--privileged'` to run the container in privileged mode, e.g., to run `strace`.

The default `Makefile` rule (`try`) runs a disposable docker container, use `run` to keep the container.

For convenience, a temporary randomly-named folder is mounted to `~user/playground`. The actual folder name is stored in the `PLAYGROUND_SHARED` environment variable.

### Run X applications on macOS

To use X applications on macOS, first start XQuartz then run `xhost +localhost` to allow X connections from Docker.

It is possible to allow `localhost` by default by placing the above command in an executable `.sh` file in the `~/.xinitrc.d` directory:

```console
$ mkdir -p ~/.xinitrc.d
$ echo xhost +localhost >~/.xinitrc.d/allow-localhost.sh
$ chmod +x ~/.xinitrc.d/allow-localhost.sh
```
