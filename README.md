Haskell run on the Intel Edison
=================================

```
$ unzip ~/Downloads/edison-sdk-linux64-ww18-15.zip
$ ./poky-edison-eglibc-x86_64-edison-image-core2-32-toolchain-1.6.1.sh
$ . /opt/poky-edison/1.6.1/environment-setup-core2-32-poky-linux
$ git clone git:git.haskell.org/ghc.git
$ cd ghc
$ ./sync-all get
$ patch aclocal.m4.patch
$ cp mk/build.mk
$ perl boot
$ ./configure --target=i586-poky-linux --prefix=/opt/poky-edison/1.6.1/sysroots/x86_64-pokysdk-linux/usr
$ make
$ make install
```
