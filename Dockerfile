FROM squidfunk/mkdocs-material@sha256:bb7b015690d9fb5ef0dbc98ca3520f153aa43129fb96aec5ca54c9154dc3b729

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
