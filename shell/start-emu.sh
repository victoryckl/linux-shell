jelly-bean# . build/envsetup.sh
jelly-bean# lunch full-eng
export PATH=$PATH:/mnt/android-jelly-bean/jelly-bean/out/host/linux-x86/bin
export ANDROID_PRODUCT_OUT=/mnt/android-jelly-bean/jelly-bean/out/target/product/generic

emulator -kernel /mnt/android-jelly-bean/linux3.0/android-kernel/goldfish/arch/arm/boot/zImage -system /mnt/android-jelly-bean/jelly-bean/out/target/product/generic/system.img -ramdisk /mnt/android-jelly-bean/jelly-bean/out/target/product/generic/ramdisk.img  -data /mnt/android-jelly-bean/jelly-bean/out/target/product/generic/userdata.img -memory 2048 -scale 0.6  -skin 1024x768  & 
