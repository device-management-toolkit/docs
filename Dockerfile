FROM squidfunk/mkdocs-material@sha256:479a06a8f5a320a9b2b17e72cb7012388d66ea71a8568235cfa072eb152bc30c

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
