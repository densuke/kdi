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
add_max 1
if [ ! -f $EX1_FILE ]; then
    add_score 0
    echo "NG"
    exit 1
else
    # /etc/passwdにて、nologinがシェルになっている行を抽出する

    grep nologin /etc/passwd > /tmp/check1
    # 評価対象ファイル($EX1_FILE)の内容と比較し、同じであれば正解とする
    if cmp /tmp/check1 $EX1_FILE; then
        add_score 1
        echo "OK"
    else
        add_score 0
        echo "NG"
    fi
fi

echo "=== 設問2"
add_max 1
if [ ! -f $EX1_FILE ]; then
    add_score 0
    echo "NG"
    exit 1
else
    # result2.txtからASCIIコード順ソートの上位5つを取得する、その結果を作業用ファイル/tmp/check2に保存
    sort -r /tmp/check1| head -n 5 > /tmp/check2
    # 評価対象ファイル($EX2_FILE)の内容と比較し、同じであれば正解とする
    if cmp /tmp/check2 $EX2_FILE; then
        add_score 1
        echo "OK"
    else
        add_score 0
        echo "NG"
    fi
fi

echo "=== 設問3"
add_max 2
if [ ! -f $EX3_FILE ]; then
    add_score 0
    echo "NG"
    exit 1
else
    # ディレクトリ/usr/bin以下にあるファイルのうち、ファイルサイズの大きいもの10個を取得し、ファイルサイズ順(大→小)に並べ替えて、その結果を作業用ファイル/tmp/check3に保存
    ls -l /usr/bin | sort -k5 -n -r | head -n 10 | awk '{print $9}'> /tmp/check3
    # 評価対象ファイル($EX2_FILE)の内容と比較し、同じであれば正解とする
    if cmp /tmp/check3 $EX3_FILE; then
        add_score 2
        echo "OK"
    else
        add_score 0
        echo "NG"
    fi
fi
rm -f /tmp/check{1,2} /tmp/check3

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
