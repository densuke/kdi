#!/bin/bash
# problem.txtの内容にそった初期設定を行わせてください
# このファイルは、2つのケースで読み込まれます
# * 直接セットアップとして実行
# * 評価時に事前データを読み込むためにinclude

# 評価時に使用するようなコードはここから記述してください
DEST1="e1"
DEST2="e2/foobar"
DEST3="e3"
DEST4="fuga/ok"
# ↑ ここまで -----------------------------------

if [ $0 = $BASH_SOURCE ]; then
# このスクリプトが直接実行された場合にはここから記述してください

# DEST2分の作成
mkdir -p hoge
echo hoge > hoge/foobar

# DEST3分の初期状態
mkdir -pv fuga/e3
# ↑ ここまで -----------------------------------
fi
