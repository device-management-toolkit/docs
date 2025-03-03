FROM squidfunk/mkdocs-material@sha256:047452c6641137c9caa3647d050ddb7fa67b59ed48cc67ec3a4995f3d360ab32

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
