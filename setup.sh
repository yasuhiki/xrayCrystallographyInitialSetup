#!/bin/bash
#azure 新規作成
#Centos 6.8を選択
#$ cat /etc/redhat-release 
#CentOS release 6.8 (Final)

sudo yum install epel-release -y#いらないかもしれない
sudo yum groupinstall "X Window System" -y

cd $HOME
mkdir src
mkdir soft   ##/share/softなどでもOK今は~/softをインストール先にしている
cd src

###XDS instal###
curl -O ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS-INTEL64_Linux_x86_64.tar.gz
tar xzvf XDS-INTEL64_Linux_x86_64.tar.gz 
sudo mv XDS-INTEL64_Linux_x86_64/* /usr/local/bin
##あとでパス追加
###XDS###
#generate_XDS.INP
#https://strucbio.biologie.uni-konstanz.de/xdswiki/index.php/Generate_XDS.INP
#からコピー&ペースト


###ccp4 install##
#curl -O http://www.ccp4.ac.uk/download/download_file.php?pkg=ccp4-64&os=linux #ブラウザで落とした、curlだとリダイレクト追わない？
#~/src/にダウンロードしたもの(ccp4-7.0-linux-x86_64.tar.bz2)を移動
#bunzip2 ccp4-7.0-linux-x86_64.tar.bz2 
#tar xvf ccp4-7.0-linux-x86_64.tar
#mv ccp4-7.0 ~/soft/
#cd ~/soft/ccp4-7.0/
#./BINARY.setup
##ライセンス確認にyesと答える必要あり
##あとでbashrcにsource ~/soft/ccp4-7.0/bin/ccp4.setup-sh 追加
###ccp4##

####phenix install(要メールアドレス登録、ダウンロードパスワード請求)####
#curl -O https://www.phenix-online.org/download/phenix/release/send_octet_stream.cgi?version=1.12-2829&file=phenix-#installer-1.12-2829-intel-linux-2.6-x86_64-centos6.tar.gz ##認証必要、ブラウザで落とした
#tar xzvf phenix-installer-1.12-2829-intel-linux-2.6-x86_64-centos6.tar.gz 
#cd phenix-installer-1.12-2829-intel-linux-2.6-x86_64-centos6
#./install --prefix=$HOME/soft/
####phenix###

###adxv install###
curl -O http://www.scripps.edu/tainer/arvai/adxv/adxv_1.9.13/adxv.x86_64CentOS6
chmod 755 adxv.x86_64CentOS6
sudo mv adxv.x86_64CentOS6 /usr/local/bin
###adxv##


#emacs bashProfile
#PATH=$PATH:$HOME/soft/XDS-INTEL64_Linux_x86_64/
#source $HOME/soft/ccp4-7.0/bin/ccp4.setup-sh 
#source $HOME/soft/phenix-1.12-2829/phenix_env.sh
#source $HOME/soft/dials-v1-8-2/dials_env.sh



#TODO: setup PATH



##KAMO install###phenix依存#
#以下参照
#https://github.com/keitaroyam/yamtbx/blob/master/doc/eiger-ja.md#eiger2cbf-h5toxds%E4%BA%92%E6%8F%9B
mkdir eiger
cd eiger
curl -O https://www.mrc-lmb.cam.ac.uk/harry/imosflm/ver721/downloads/eiger2cbf-linux.zip
unzip eiger2cbf-linux.zip 

cd (任意のPATHが通った場所)
cat <<+ > H5ToXds
#!/bin/sh
eiger2cbf $@ 2>/dev/null
+
chmod +x H5ToXds

##XDSSTAT##https://strucbio.biologie.uni-konstanz.de/xdswiki/index.php/Installation
sudo yum install R R-core -y
sudo R #Rを起動
#> install.packages("rjson")
#38 Japanサーバー選択など
#> quit()
curl -L -o xdsstat.bz2 ftp://turn5.biologie.uni-konstanz.de/pub/xdsstat-linux64.bz2
bunzip2 -f xdsstat.bz2
chmod a+x xdsstat
#ブラウザダウンロード https://github.com/dials/dials/releases/download/v1.8.0/dials-v1-8-2-linux-x86_64.tar.xz
#wget http://dials.diamond.ac.uk/diamond_builds/dials-linux-x86_64.tar.xz #でできるかも。
tar xf dials-v1-8-2-linux-x86_64.tar.xz 
cd  dials-installer/
./install --prefix=/home/hikida/soft/
#source bashProfile
cd $PHENIX/build##phenix環境変数設定済みを仮定
./bin/libtbx.python -m easy_install networkx==1.11
sudo yum install lapack-devel lapack -y
./bin/libtbx.python -m easy_install scipy==0.18.1
sudo yum install git
cd $HOME
git clone https://github.com/keitaroyam/yamtbx.git
cd $PHENIX/modules
ln -s ~/yamtbx/yamtbx .
cd ../build
./bin/libtbx.configure yamtbx
###KAMO###
##TODO:
##KAMOテストデータを用意する
##########




#X線テストデータセット
#curl -O http://www.helmholtz-berlin.de/media/media/grossgeraete/mi_synchro/bessy_mx/tutorial/exp1_ins_ssad/data/exp1_data1.tgz
#curl -O http://www.helmholtz-berlin.de/media/media/grossgeraete/mi_synchro/bessy_mx/tutorial/exp1_ins_ssad/data/exp1_data2.tgz

#tar xzvf exp1_data1.tgz
#tar xzvf exp1_data2.tgz
#cd exp1/data
#mkdir XDS
#cd XDS
#generate_XDS.INP "../exp1_ins_ssad_???.img.bz2"   #XDS.INPというファイルが生成される
#xds_par #いろいろなファイルが生成される、5分くらい時間がかかる
#XDS_ASCII.HKLを次に使う
#出力結果が手元で実行したときと同じかどうかで判断するtest case追加、(簡易チェック:ファイルが生成されていればOK)
###test####
#if [ -e XDS_ASCII.HKL ]; then echo XDS_OK; else  echo XDS_error; fi
###########
#phenix(GUI or CUI)でいろいろやる
