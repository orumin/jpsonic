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

`.env.web.sample` を `.env.web` に，`.env.db.sample` を `.env.db` にリネームしてから

```sh
docker-compose up -d
```

とすれば PostgreSQL を DB に設定し起動できます。

もしデフォルトの内蔵 DB（HSQLDB）を使用したければ，

* 環境変数を設定しない（env_file の行を `docker-compose.yml` から削除）
* db コンテナを `docker-compose.yml` から削除

の二項を実行すれば良いです。
