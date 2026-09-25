FROM cgr.dev/chainguard/python:latest-dev@sha256:2d5551e22013aa1bb69c070398273171941c4a0d80414e7f786db8e6d966bb83 AS build

# Root for the build stage only; the runtime image keeps its nonroot user.
USER root

WORKDIR /app

COPY ./requirements.txt ./

# No pip in the venv: its vendored packages would ship in the runtime image.
RUN python -m venv --without-pip venv && \
    python -m pip --python venv/bin/python install -r requirements.txt --require-hashes --no-cache-dir

# Runtime image has no shell or pip; it must match the build image's Python version.
FROM cgr.dev/chainguard/python:latest@sha256:992f13b3e2f7d7bef9b0d74caf7d05c12329482b7b1455fe0bfc6531361b9b7d

COPY --from=build /app/venv /app/venv

ENV PATH="/app/venv/bin:$PATH"

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT ["zensical"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
