# Contributing

Thank you, for considering contributing to this action. To allow feature integration in a backward compatiable way, this repository uses unit tests.

That said, contributing is not just writing code. It entails

1. Reporting bugs
  - First check if a similar [issue](issues) is not already present, before [creating a new](issues/new).
2. Feature Suggestions
  - New feature suggestions are also managed through [issues](issues).
3. Pull Requests
  - Just make sure all tests pass, and you have included tests for your additions.

## Running tests

Tests use [shUnit2](https://github.com/kward/shunit2), which is downloaded into `deps/` on the first run.

```sh
bash tests.sh
```

Or with [bpkg](https://github.com/bpkg/bpkg): `bpkg run setup` installs the dependencies and `bpkg run test` runs the tests.
