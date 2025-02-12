FROM squidfunk/mkdocs-material@sha256:c62453b1ba229982c6325a71165c1a3007c11bd3dd470e7a1446c5783bd145b4

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
