FROM squidfunk/mkdocs-material@sha256:0bfdba448e93984191246f7a28abeacc79f789e7e9cf0c639a48fe4365e880a7

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
