FROM squidfunk/mkdocs-material@sha256:f5c556a6d30ce0c1c0df10e3c38c79bbcafdaea4b1c1be366809d0d4f6f9d57f

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
