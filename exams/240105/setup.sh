#!/bin/bash
# problem.txtの内容にそった初期設定を行わせてください
# このファイルは、2つのケースで読み込まれます
# * 直接セットアップとして実行
# * 評価時に事前データを読み込むためにinclude

# 評価時に使用するようなコードはここから記述してください
EX1_FILE="ex1.files"
EX2_FILE="ex2.files"
EX3_FILE="ex3.opt"
EX3_ANS="--no-preserve-root"

# ↑ ここまで -----------------------------------

if [ $0 = $BASH_SOURCE ]; then
# このスクリプトが直接実行された場合にはここから記述してください

touch ./error.result
mkdir log
cd log
# ランダムなファイル名(英数字小文字で16文字)を20個作成し、うち13個は.log、残り7個は.resultという拡張子を付けて作成する
for i in {1..13}; do
  touch $(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 16 | head -n 1).log
done
for i in {1..7}; do
  touch $(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 16 | head -n 1).result
done

# 上記操作で作成されたファイルに対して、16個のファイルは英数字と改行で3072バイトで構成される、残り4つのファイルは英数字と改行で1024バイトで構成される
LARGES=`ls | head -16`
SMALLS=`ls | tail -4`
for file in $LARGES; do
  cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 16 | head -n 192 > $file
done
for file in $SMALLS; do
  cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 16 | head -n 64 > $file
done


# ↑ ここまで -----------------------------------
fi
