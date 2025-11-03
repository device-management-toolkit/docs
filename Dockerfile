FROM squidfunk/mkdocs-material@sha256:58dee36ad85b0ae4836522ee6d3f0150d828bca9a1f7d3bfbf430bca771c1441

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
