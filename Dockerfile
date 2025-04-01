FROM squidfunk/mkdocs-material@sha256:23b69789b1dd836c53ea25b32f62ef8e1a23366037acd07c90959a219fd1f285

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
