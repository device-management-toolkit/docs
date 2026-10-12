FROM cgr.dev/chainguard/python:latest-dev@sha256:e8e6a6f7677673d91c9b28fa2ec6ad62cd5ed532179846d2c14e75c93a12c3fc AS build

# Root for the build stage only; the runtime image keeps its nonroot user.
USER root

WORKDIR /app

COPY ./requirements.txt ./

# No pip in the venv: its vendored packages would ship in the runtime image.
RUN python -m venv --without-pip venv && \
    python -m pip --python venv/bin/python install -r requirements.txt --require-hashes --no-cache-dir

# Runtime image has no shell or pip; it must match the build image's Python version.
FROM cgr.dev/chainguard/python:latest@sha256:1c4deeea85db49ab5f6bcd9e7fc0bf3fd8439e99f7bde45330f40400685eb394

COPY --from=build /app/venv /app/venv

ENV PATH="/app/venv/bin:$PATH"

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT ["zensical"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
