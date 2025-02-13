FROM squidfunk/mkdocs-material@sha256:f5bcec4e71c138bcb89c0dccb633c830f54a0218e1aefedaade952b61b908d00

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
