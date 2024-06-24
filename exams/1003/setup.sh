#!/bin/bash
# problem.txtの内容にそった初期設定を行わせてください
# このファイルは、2つのケースで読み込まれます
# * 直接セットアップとして実行
# * 評価時に事前データを読み込むためにinclude

# 評価時に使用するようなコードはここから記述してください

# ↑ ここまで -----------------------------------

if [ $0 = $BASH_SOURCE ]; then
# このスクリプトが直接実行された場合にはここから記述してください

sudo install -m 0755 $(dirname $0)/zombie /usr/local/bin/zombie

N=$((RANDOM % 500))
for i in `seq $N`; do
    true &
done
wait
echo ""

zombie &
pgrep zombie > /tmp/.p

# ↑ ここまで -----------------------------------
fi
