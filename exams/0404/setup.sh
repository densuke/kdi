#!/bin/bash

echo -n "ファイル生成中..."
# ランダムなファイル名を生成します
# 生成したファイル名を配列LISTに入れておきます
LIST=()
for i in {1..30}; do
    FILE=$(basename $(mktemp -u) | sed -e 's;^tmp.;;')
    LIST+=($FILE)
done
# LISTの最初のファイルはディレクトリとしてホームディレクトリ中に作成し
# 残りのファイルは空ファイルとして作成します
mkdir ${LIST[0]}
for i in {1..29}; do
    touch ${LIST[$i]}
done
echo "OK"


for item in ls l la ll grep egrep fgrep; do
    echo "unalias ${item}" >> ~/.bashrc
done
