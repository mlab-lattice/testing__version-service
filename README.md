# testing__version-service
A simple carbon service that serves up its version.

To generate a new version of the service, run:

```
./scripts/generate-new-version.sh <VERSION>
```

So for example creating `2.0.0`:

```
$ ./scripts/generate-new-version.sh 2.0.0

$ node VersionService.js

$ curl localhost:8080/status
{"ok":true}

$ curl localhost:8080/version
{"version":"2.0.0"}
```

This will also commit `VersionService.js` and tag the commit with the version.

Don't forget to run `git push --tags`.
