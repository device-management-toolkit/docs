FROM squidfunk/mkdocs-material@sha256:7e841df1cfb6c8c4ff0968f2cfe55127fb1a2f5614e1c9bc23cbc11fe4c96644

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
