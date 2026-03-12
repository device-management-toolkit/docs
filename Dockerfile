FROM squidfunk/mkdocs-material@sha256:c3739993c3e7c92cfe649ba03cbc04f4fa9b1497886abd16267eb413cda8aecf

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
