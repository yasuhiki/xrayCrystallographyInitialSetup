#azure 新規作成
#Centos 6.8を選択
#$ cat /etc/redhat-release 
#CentOS release 6.8 (Final)

sudo yum install epel-release -y#いらないかもしれない
sudo yum groupinstall "X Window System" -y


mkdir src
mkdir soft   ##/share/softなどでもOK今は/home/hikida/softをインストール先にしている
cd src

###XDS instal###
curl -O ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS-INTEL64_Linux_x86_64.tar.gz
tar xzvf XDS-INTEL64_Linux_x86_64.tar.gz 
mv XDS-INTEL64_Linux_x86_64 ~/soft/
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
##あとでbashrcにsource /home/hikida/soft/ccp4-7.0/bin/ccp4.setup-sh 追加
###ccp4##

####phenix install(要メールアドレス登録、ダウンロードパスワード請求)####
#curl -O https://www.phenix-online.org/download/phenix/release/send_octet_stream.cgi?version=1.12-2829&file=phenix-#installer-1.12-2829-intel-linux-2.6-x86_64-centos6.tar.gz ##認証必要、ブラウザで落とした
#tar xzvf phenix-installer-1.12-2829-intel-linux-2.6-x86_64-centos6.tar.gz 
#cd phenix-installer-1.12-2829-intel-linux-2.6-x86_64-centos6
#./install --prefix=/home/hikida/soft/
####phenix###

###adxv install###
curl -O http://www.scripps.edu/tainer/arvai/adxv/adxv_1.9.13/adxv.x86_64CentOS6
chmod 755 adxv.x86_64CentOS6
###adxv##


emacs bashProfile
PATH=$PATH:/home/hikida/soft/XDS-INTEL64_Linux_x86_64/
#source /home/hikida/soft/ccp4-7.0/bin/ccp4.setup-sh 
#source /home/hikida/soft/phenix-1.12-2829/phenix_env.sh






