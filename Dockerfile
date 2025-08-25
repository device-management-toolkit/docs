FROM squidfunk/mkdocs-material@sha256:1a4e939cfd62b90943b6a829eb8544933e4e94eab18b8ca1d0f912fa9a532c37

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
