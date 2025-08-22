FROM squidfunk/mkdocs-material@sha256:405aeb6dbf1fcddd1082993eacf288a46648ea56b846323f001aee619015a23b

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
