FROM cgr.dev/chainguard/python:latest-dev@sha256:8c06d75b497c156bb7a42fedb6480fe2c1865e93538215e4a0f7bf99a03f1f99 AS build

# Root for the build stage only; the runtime image keeps its nonroot user.
USER root

WORKDIR /app

COPY ./requirements.txt ./

# No pip in the venv: its vendored packages would ship in the runtime image.
RUN python -m venv --without-pip venv && \
    python -m pip --python venv/bin/python install -r requirements.txt --require-hashes --no-cache-dir

# Runtime image has no shell or pip; it must match the build image's Python version.
FROM cgr.dev/chainguard/python:latest@sha256:b7af1ae90e2fcfb5c32be03908e74d32fdfd64156c2b7c535bd3e497e7846d84

COPY --from=build /app/venv /app/venv

ENV PATH="/app/venv/bin:$PATH"

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT ["zensical"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
