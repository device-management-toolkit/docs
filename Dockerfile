FROM squidfunk/mkdocs-material@sha256:3555052d6cbde1086b166ebacacc43126c6fb0a7b990f324072150725aa63b18

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
