#!/bin/bash
# problem.txtの内容にそった初期設定を行わせてください
# このファイルは、2つのケースで読み込まれます
# * 直接セットアップとして実行
# * 評価時に事前データを読み込むためにinclude

# 評価時に使用するようなコードはここから記述してください
DEST1_FROM="textfile"
DEST1_TO="copyfile"
DEST2_ORIG="/tmp/move_me"
DEST2_CHECK="/tmp/.move_me"
DEST2_TO="moved"
DEST2_TEXT="move me!"
DEST3_FROM="original"
DEST3_HL="clone_hard"
DEST3_SL="clone_symlink"

# ↑ ここまで -----------------------------------

if [ $0 = $BASH_SOURCE ]; then
# このスクリプトが直接実行された場合にはここから記述してください

# DEST1分の作成
cp /etc/hosts "$DEST1_FROM"

# DEST2分の作成
echo "$DEST2_TEXT" > "$DEST2_ORIG"
cp "$DEST2_ORIG" "$DEST2_CHECK"



# DEST3分の作成
echo 'link me!' > "$DEST3_FROM"

sudo rm -f `which cp` `which vi` `which vim`

# ↑ ここまで -----------------------------------
fi
