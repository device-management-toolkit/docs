FROM squidfunk/mkdocs-material@sha256:00f9276315990b82f5af8c47bb2b71e2c69aef9f02a08f8dffd2515f42310753

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
