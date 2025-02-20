FROM squidfunk/mkdocs-material@sha256:26153027ff0b192d3dbea828f2fe2dd1bf6ff753c58dd542b3ddfe866b08bf60

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
