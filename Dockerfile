FROM squidfunk/mkdocs-material@sha256:209b62dd9530163cc5cf9a49853b5bb8570ffb3f3b5fe4eadc1d319bbda5ce2f

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
