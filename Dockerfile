FROM squidfunk/mkdocs-material@sha256:f6c81d538499f5755c8d1486f0abcda50bb631be391890ef823fcba18803114a

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
