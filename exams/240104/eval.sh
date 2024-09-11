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
if [ -f "$DEST1_FROM" ] && cmp "$DEST1_FROM" "$DEST1_TO"; then
    add_score 1
    echo "OK"
else
    add_score 0
    echo "NG"
fi

echo "=== 設問2"
add_max 1
if [ ! -f "$DEST2_ORIG" ] && [ -f "$DEST2_TO" ] && cmp "$DEST2_TO" "$DEST2_CHECK"; then
    add_score 1
    echo "OK"
else
    add_score 0
    echo "NG"
fi

echo "=== 設問3"
add_max 2
p=0
if [ -f "$DEST3_HL" ]; then
    echo -n "ハードリンクの確認: "
    INODE_FROM=$(ls -i "$DEST3_FROM" | awk '{print $1}')
    INODE_TO=$(ls -i "$DEST3_HL" | awk '{print $1}')
    if [ "$INODE_FROM" = "$INODE_TO" ]; then
        p=$((p+1))
        echo "OK"
    else
        add_score 0
        echo "NG"
    fi
fi

if [ -f "$DEST3_SL" ]; then
    echo -n "シンボリックリンクの確認: "
    INODE_FROM=$(ls -i "$DEST3_FROM" | awk '{print $1}')
    INODE_TO=$(ls -i "$DEST3_SL" | awk '{print $1}')
    if [ ! "$INODE_FROM" = "$INODE_TO" ] && cmp "$DEST3_FROM" "$DEST3_SL"; then
        p=$((p+1))
        echo "OK"
    else
        add_score 0
        echo "NG"
    fi
fi
add_score $p

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
