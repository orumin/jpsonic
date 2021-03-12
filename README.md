<!--
# README.md
# orumin/jpsonic
-->
![](https://img.shields.io/docker/cloud/automated/orumin/jpsonic.svg?style#flat-square)
![](https://img.shields.io/docker/cloud/build/orumin/jpsonic.svg?style#flat-square)
![](https://img.shields.io/microbadger/image-size/orumin/jpsonic.svg?style#flat-square)
![](https://img.shields.io/microbadger/layers/orumin/jpsonic.svg?style#flat-square)

Jpsonic
========

What is Jpsonic?
-----------------

upstream repository is [tesshucom/jpsonic](https://github.com/tesshucom/jpsonic)

What is this repo?
-----------------

このレポジトリは Jpsonic をホストに maven などを入れずにビルド・デプロイするための環境です。
主に DockerHub の automated build のためです。

How to use?
-----------

`.env.web.sample` を `.env.web` にリネームしてから

```sh
docker-compose up -d
```

とすれば HSQLDB を使ってアプリが起動します。

もし PostgreSQL を DB として起動したければ、

- `.env.web.sample` の代わりに `.env.web.sample_psql` を使う
- `docker-compose.yml` のコメントアウトされている行頭の `#` を消す

とすれば利用可能です。
