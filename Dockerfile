FROM cgr.dev/chainguard/python:latest-dev@sha256:630df1be3733f7b38d1b535872904248adfe23fbea4befcb08da47cb7436ddb2 AS build

# Root for the build stage only; the runtime image keeps its nonroot user.
USER root

WORKDIR /app

COPY ./requirements.txt ./

# No pip in the venv: its vendored packages would ship in the runtime image.
RUN python -m venv --without-pip venv && \
    python -m pip --python venv/bin/python install -r requirements.txt --require-hashes --no-cache-dir

# Runtime image has no shell or pip; it must match the build image's Python version.
FROM cgr.dev/chainguard/python:latest@sha256:8c6e0d0a587455e8a8d145e20234d5ef5a531a1c052a7b9d76b155ccc7fcded2

COPY --from=build /app/venv /app/venv

ENV PATH="/app/venv/bin:$PATH"

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT ["zensical"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
