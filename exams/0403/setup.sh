#!/bin/bash
FILE=/home/ubuntu/fugahoge
SIZE=5963

# もしこのスクリプトが直接実行された場合、truncateで指定サイズのファイルを作成する
if [ $0 = $BASH_SOURCE ]; then
    truncate -s $SIZE $FILE
fi
