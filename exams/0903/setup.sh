#!/bin/bash
# problem.txtの内容にそった初期設定を行わせてください
# このファイルは、2つのケースで読み込まれます
# * 直接セットアップとして実行
# * 評価時に事前データを読み込むためにinclude

# 評価時に使用するようなコードはここから記述してください
FILE=/home/ubuntu/hoge

# ↑ ここまで -----------------------------------

if [ $0 = $BASH_SOURCE ]; then
# このスクリプトが直接実行された場合にはここから記述してください

cat <<EOM > ${FILE}
#!/bin/sh
echo "OKです、Linux上での現在時刻は以下の通りです"
date
EOM
sudo chown bin:bin ${FILE}

# ↑ ここまで -----------------------------------
fi