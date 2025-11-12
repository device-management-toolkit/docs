FROM squidfunk/mkdocs-material@sha256:980e11fed03b8e7851e579be9f34b1210f516c9f0b4da1a1457f21a460bd6628

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
