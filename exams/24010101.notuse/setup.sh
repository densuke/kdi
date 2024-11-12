#!/bin/bash
# problem.txtの内容にそった初期設定を行わせてください
# このファイルは、2つのケースで読み込まれます
# * 直接セットアップとして実行
# * 評価時に事前データを読み込むためにinclude

# 評価時に使用するようなコードはここから記述してください
FILE="exam"
DEST1="dest/exam"
DEST2="result"
DEST3="/usr/local/lib/exam"
# ↑ ここまで -----------------------------------

if [ $0 = $BASH_SOURCE ]; then
# このスクリプトが直接実行された場合にはここから記述してください

dd if=/dev/random of=exam count=1024 bs=4
mkdir dest

# ↑ ここまで -----------------------------------
fi
