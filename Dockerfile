FROM squidfunk/mkdocs-material@sha256:41942f7a2f5163aacd0e866e076d95db4f26550b97d76c1594c04250cbb580e9

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
