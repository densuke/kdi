#!/bin/bash
# problem.txtの内容にそった初期設定を行わせてください
# このファイルは、2つのケースで読み込まれます
# * 直接セットアップとして実行
# * 評価時に事前データを読み込むためにinclude

# 評価時に使用するようなコードはここから記述してください
EX1_FILE="result1.txt"
EX2_FILE="result2.txt"
EX3_FILE="result3.txt"

# ↑ ここまで -----------------------------------

if [ $0 = $BASH_SOURCE ]; then
# このスクリプトが直接実行された場合にはここから記述してください

  echo -n "" > $EX1_FILE
  echo -n "" > $EX2_FILE
  cat > $EX3_FILE <<EOM
# これはサンプルです、そのまま出しても点数になりません
gp-display-text
gp-display-html
gp-display-src
gp-collect-app
ld.so
gp-archive
addr2line
vimdiff
EOM

# ↑ ここまで -----------------------------------
fi
