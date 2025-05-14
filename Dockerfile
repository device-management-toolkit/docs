FROM squidfunk/mkdocs-material@sha256:eb04b60c566a8862be6b553157c16a92fbbfc45d71b7e4e8593526aecca63f52

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
