#!/bin/bash

# # 本スクリプトの置いているディレクトリにsetup.shがある場合、それをincludeする
# REQ=$(dirname $0)/setup.sh
# if [ -f ${REQ} ]; then
#     . ${REQ}
#     echo "FILE: $FILE"
# fi

# 引数でわたされたファイルを各行スキャンします
# "$"が含まれる行はプロンプトなので無視します
# それ以外の行は仮にファイル名とみなして、その名前のディレクトリが存在するかを確認します
# どれか1つでも確認できれば成功とし1ポイント加算します。
MAX=1

# ファイル$1中に含まれているエスケープシーケンスを削除して、ファイル /tmp/check に保存する
cat $1 | sed -e 's/\\//g' | strings > /tmp/check

SCORE=0
export SCORE
line=$(egrep '%%%:.*:%%%' /tmp/check | tail -n1)
#echo "data: ${line}"
filename=$(echo $line | cut -d: -f2)
#echo "filename: ${filename}"
if [ -d /home/ubuntu/$filename ]; then
    SCORE=`expr $SCORE + 1`
fi
echo "Score: $SCORE/$MAX"

if [ $SCORE -ge $MAX ]; then
    exit 0
fi
exit 1
