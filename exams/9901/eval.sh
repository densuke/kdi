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

echo "=== 設問1"
# 設問1で指定したファイルが存在しないこと
add_max 1
if [ ! -f "$EX1_FILE" ]; then
    add_score 1
    echo "OK"
else
    add_score 0
    echo "NG"
fi


echo "=== 設問2"
# 設問2で指定したファイルの中身がOKであること
add_max 1
if [ "x$(cat ${EX2_FILE})" = "x$EX2_TEXT" ]; then
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
set -x
echo "$RS" > /tmp/.result
exit $RET
