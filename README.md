# playground

Disposable Docker sandbox.

## Maintenance

One-time build with:

```console
$ make build
```

Remove the Docker image with:

```console
$ make clean
```

## Usage

```
$ make [run] [OPTIONS=<options>]
```

Where `<options>` are command line arguments to pass to `docker run`. Some useful examples:

- `'OPTIONS=-p 8080:80'` to forward the container port `8080` to the host port `80`;
- `'OPTIONS=-v /container/folder:/host/folder'` to mount additional directories.

The default `Makefile` rule (`try`) runs a disposable docker container, use `run` to keep the container.

For convenience, a temporary randomly-named folder is mounted to `~user/playground`. The actual folder name is stored in the `PLAYGROUND_SHARED` environment variable.
