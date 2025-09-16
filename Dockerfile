FROM squidfunk/mkdocs-material@sha256:86d21da4f45f16e30774bf911e5b4795da13ce0cd197dbf8d3d059f256b2cc37

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
