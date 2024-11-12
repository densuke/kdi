#!/bin/bash
# problem.txtの内容にそった初期設定を行わせてください
# このファイルは、2つのケースで読み込まれます
# * 直接セットアップとして実行
# * 評価時に事前データを読み込むためにinclude

# 評価時に使用するようなコードはここから記述してください
DEST1="newfile"
DEST2="delfile"
DEST3="textfile"
DEST4="modfile"
# ↑ ここまで -----------------------------------

if [ $0 = $BASH_SOURCE ]; then
# このスクリプトが直接実行された場合にはここから記述してください

# DEST2分の作成
echo 'Delete me!' > $DEST2

# DEST4分の作成
dd if=/dev/random of="$DEST4" bs=1024 count=10 >& /dev/null

sudo rm -f `which vi` `which vim`

# ↑ ここまで -----------------------------------
fi
