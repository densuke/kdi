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
if [ -f "$EX1_FILE" ]; then
    find log -name "*.result" | sort > /tmp/check
    sort "$EX1_FILE" > /tmp/check2
    if cmp /tmp/check /tmp/check2; then
        add_score 1
        echo "OK"
    else
        add_score 0
        echo "NG"
    fi
    rm -f /tmp/check /tmp/check2
else
    add_score 0
    echo "NG"
fi

echo "=== 設問2"
add_max 1
if [ -f "$EX2_FILE" ]; then
    find log -type f -size +2k | sort > /tmp/check
    sort "$EX2_FILE" > /tmp/check2
    if cmp /tmp/check /tmp/check2; then
        add_score 1
        echo "OK"
    else
        add_score 0
        echo "NG"
    fi
    rm -f /tmp/check /tmp/check2
else
    add_score 0
    echo "NG"
fi

echo "=== 設問3"
add_max 1
if [ -f $EX3_FILE ] && [ "$(cat $EX3_FILE)" = "$EX3_ANS" ]; then
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
