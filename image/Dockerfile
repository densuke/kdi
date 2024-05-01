FROM ubuntu:24.04
# 組込ユーザーubuntuを使用
ARG USER_NAME=ubuntu
# 必要なパッケージを一式入れてしまう
RUN apt-get update && apt-get install -y \
    sudo \
    tzdata \
    locales \
    bash-completion \
    binutils && \
    rm -fr /var/lib/apt/lists /var/cache/apt
# USER_NAMEのユーザーがsudoをパスワード無しで実行できるようにしておく
#RUN apt-get update && apt-get install -y sudo
RUN chsh -s /bin/bash $USER_NAME
RUN echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USER_NAME
# タイムゾーンを調整し、日本時間(Asia/Tokyo)に設定する
#RUN apt-get install -y tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# 日本語ロケールが使えるようにし、基本言語を日本語に変更する
#RUN apt-get install -y locales
RUN locale-gen ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
# bashの補完機能パッケージをインストールする
#RUN apt-get install -y bash-completion
# binutilsをインストールする(strings)
#RUN apt-get install -y binutils markdown
COPY ./bin/exam /usr/local/bin/exam
COPY ./exams /usr/local/lib/exams
RUN chmod +x /usr/local/bin/exam
RUN find /usr/local/lib/exams -type f -iname "*.sh" -exec chmod -v +x {} \;
COPY ./bin/answer /usr/local/bin/answer
RUN chmod +x /usr/local/bin/answer
RUN rm -vf /home/ubuntu/.sudo_as_admin_successful
WORKDIR /home/$USER_NAME
USER $USER_NAME
ENTRYPOINT ["exam"]
