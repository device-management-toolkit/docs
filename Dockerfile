FROM cgr.dev/chainguard/python:latest-dev@sha256:8af5085c793a9b501253117ccceabff2340400f3ef92fb0e09df690dd1e961a4 AS build

# Root for the build stage only; the runtime image keeps its nonroot user.
USER root

WORKDIR /app

COPY ./requirements.txt ./

# No pip in the venv: its vendored packages would ship in the runtime image.
RUN python -m venv --without-pip venv && \
    python -m pip --python venv/bin/python install -r requirements.txt --require-hashes --no-cache-dir

# Runtime image has no shell or pip; it must match the build image's Python version.
FROM cgr.dev/chainguard/python:latest@sha256:1206ffee8644e6338b3fc8b6e5dc384b03d91ad1df1d6b74fa4255544ac51ad2

COPY --from=build /app/venv /app/venv

ENV PATH="/app/venv/bin:$PATH"

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT ["zensical"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
