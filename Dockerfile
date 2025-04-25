FROM squidfunk/mkdocs-material@sha256:95f2ff42251979c043d6cb5b1c82e6ae8189e57e02105813dd1ce124021a418b

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
