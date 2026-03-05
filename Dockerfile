FROM squidfunk/mkdocs-material@sha256:f4332a8e8895aa303bf7f3ceede749980a98cf79f5d87ad567b4d41f037b0101

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
