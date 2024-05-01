#!/bin/bash

# 引数にわたされたファイル中に "echo.*hoge" が含まれているかを検証する
# 含まれていれば成功とし、戻り値0を返して終了
# 含まれていなければ失敗とし、戻り値1を返して終了
R=0
MAX=2
# 結果ファイル($1にて渡される)からエスケープシーケンス文字を取り除き、/tmp/checkにリダイレクト保存する
cat $1 | sed -e 's/\\//g' | strings > /tmp/check
grep -q 'echo.*hoge' /tmp/check && R=$((R+1))
grep -q ^hoge /tmp/check && R=$((R+1))
echo "Score: $R/$MAX"

if [ $R -ge $MAX ]; then
    exit 0
fi
exit 1
