
# Device Management Toolkit documentation

The site is built with [Zensical](https://zensical.org/) using the existing `mkdocs.yml` configuration.

## Local Development (docker) (recommended):

`docker compose -f "docker-compose.yml" up -d --build`

The site is served at http://localhost:9000.

## Local Development (native)

1) Install Python 3.10 or newer.

2) Install the pinned dependencies:

   `pip install -r requirements.txt --require-hashes`

3) Run `zensical serve` and open http://localhost:8000 to preview changes live.

Run `zensical build --strict` before opening a pull request; CI fails on any build warning, such as a broken link or anchor.

## Updating dependencies

Edit `requirements.in`, then regenerate the hashed lock file:

`uv pip compile --generate-hashes --universal --python-version 3.14 requirements.in -o requirements.txt`
