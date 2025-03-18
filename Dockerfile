FROM squidfunk/mkdocs-material@sha256:f226a2d2d5983643cab401491fc40e8a5711a50e90c21433f80e91c014cff1f5

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
