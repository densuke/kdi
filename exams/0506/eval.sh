#!/bin/bash
# 評価コード
# 評価コード自体はこのテキストの後方で記述します

# 本スクリプトの置いているディレクトリにsetup.shがある場合、それをincludeする
REQ=$(dirname $0)/setup.sh

R=0
MAX=0

# 最大スコアを書き換える関数
# 最大スコアはMAXに含まれている、引数にある数を足せばよい
add_max(){
    MAX=$((MAX+$1))
}

# スコアを書き換える関数
# スコアはRに含まれている、引数にある値を足せばよい
add_score(){
    R=$((R+$1))
}

# ======================== 以下が記述部です

echo "=== wasteディレクトリ中のwではじまるファイルの削除ができているか"
add_max 1
[ $(find waste -type f -name "w*" 2>/dev/null | wc -l) = 0 ] && add_score 1 && echo "OK"

echo "=== ホームディレクトリ中のファイルのうち、wを含むファイルの削除ができているか"
add_max 1
[ $(find ~ -name "*w*" -type f -maxdepth 1 2>/dev/null | wc -l) = 0 ] && add_score 1 && echo "OK"

echo "=== 消しすぎてませんか?"
if [ $(find ~ \! -name "*w*" -a -type f -maxdepth 1 2>/dev/null | fgrep -v '/.' | wc -l ) -eq 0 ] ; then
    echo "消しすぎですね(加点取り消し)"
    add_score -1
fi
# ======================== ↑ 記述部ここまで

# スコアの表示および戻り値の作成・終了
echo "Score: $R/$MAX"
if [ $R = $MAX ]; then
    RET=0
else
    RET=1
fi
exit $RET
