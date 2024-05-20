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

# 引数にわたされたファイル中に、変数 SIZE の値が行頭から含まれているかを確認する
# 含まれていれば成功とし、戻り値0を返して終了
# 含まれていなければ失敗とし、戻り値1を返して終了
# 結果ファイル($1にて渡される)からエスケープシーケンス文字を取り除き、/tmp/checkにリダイレクト保存する
echo "=== ファイル(data1)存在チェック"
add_max 1
find -name "data1" -a -size 0 | grep -q 'work/fuga/hoge/data1' && add_score 1 && echo "OK"
echo "=== ファイル(data2)存在チェック"
add_max 1
find -name "data1" -a -size 0 | grep -q 'work/foo/data2' && add_score 1 && echo "OK"

# ======================== ↑ 記述部ここまで

# スコアの表示および戻り値の作成・終了
echo "Score: $R/$MAX"
if [ $R = $MAX ]; then
    RET=0
else
    RET=1
fi
exit $RET
