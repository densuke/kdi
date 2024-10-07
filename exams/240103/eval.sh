#!/bin/bash
# 評価コード
# 評価コード自体はこのテキストの後方で記述します

# 本スクリプトの置いているディレクトリにsetup.shがある場合、それをincludeする
REQ=$(dirname $0)/setup.sh
if [ -f ${REQ} ]; then
    . ${REQ}
    echo "FILE: $FILE"
fi

R=0
MAX=0
RS=""

# 最大スコアを書き換える関数
# 最大スコアはMAXに含まれている、引数にある数を足せばよい
add_max(){
    MAX=$((MAX+$1))
}

# スコアを書き換える関数
# スコアはRに含まれている、引数にある値を足せばよい
add_score(){
    local s="$1"
    R=$((R+$1))
    if [ -z "$RS" ]; then
        RS="$s"
    else
        RS="$RS,$s"
    fi
}

# ======================== 以下が記述部です

# 引数にわたされたファイル中に、変数 SIZE の値が行頭から含まれているかを確認する
# 含まれていれば成功とし、戻り値0を返して終了
# 含まれていなければ失敗とし、戻り値1を返して終了
# 結果ファイル($1にて渡される)からエスケープシーケンス文字を取り除き、/tmp/checkにリダイレクト保存する
echo "=== 設問1"
add_max 1
if [ -f "$DEST1" ]; then
    add_score 1
    echo "OK"
else
    add_score 0
    echo "NG"
fi

echo "=== 設問2"
add_max 1
if  [ ! -f "$DEST2" ]; then
    add_score 1
    echo "OK"
else
    add_score 0
    echo "NG"
fi

echo "=== 設問3"
add_max 1
TESTFILE=/tmp/testfile
echo 'fugahoge' > $TESTFILE
if [ -f "$DEST3" ] && cmp "$DEST3" "$TESTFILE"; then
    add_score 1
    echo "OK"
else
    add_score 0
    echo "NG"
fi

echo "=== 設問4"
add_max 1
# $DEST4ファイルが存在し、なおかつファイサイズが0であることを確認する
if [ -f "$DEST4" ] && [ ! -s "$DEST4" ]; then
    add_score 1
    echo "OK"
else
    add_score 0
    echo "NG"
fi

# ======================== ↑ 記述部ここまで

# スコアの表示および戻り値の作成・終了
echo "Score: $R/$MAX"
echo "$RS"
if [ $R = $MAX ]; then
    RET=0
else
    RET=1
fi
echo "$RS" > /tmp/.result
exit $RET
