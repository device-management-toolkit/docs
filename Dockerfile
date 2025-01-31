FROM squidfunk/mkdocs-material@sha256:471695f3e611d9858788ac04e4daa9af961ccab73f1c0f545e90f8cc5d4268b8

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
