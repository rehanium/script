mkdir ~/derpfest
cd ~/derpfest
rm -rfv .repo/local_manifests
rm -rfv device/qcom/sepolicy-legacy-um
rm -rfv system/bt

# Sync Repo
echo "Syncing Repo..."
repo init -u git://github.com/DerpFest-11/manifest.git -b 11
repo sync --force-sync --no-tags --no-clone-bundle

echo "Removing any previous out folder..."
rm -rfv out
rm -rfv out/.lock

echo "Deleting previous tree..."
rm -rf device/xiaomi/santoni
rm -rf kernel/xiaomi/msm8937
rm -rf vendor/xiaomi

echo "Removing Qcom Power..."
rm -rf vendor/qcom/opensource/power

echo "Removing Toolchain..."
rm -rf prebuilts/clang/host/linux-x86/clang-r399163b

echo "Clonig tree..."
git clone https://github.com/zhantech/android_device_xiaomi_santoni.git -b nad-11 device/xiaomi/santoni
echo "Clonig kernel..."
git clone https://github.com/zeta96/L_check_msm-4.9.git -b wip kernel/xiaomi/msm8937
echo "Cloning vendor..."
git clone https://github.com/zhantech/vendor_xiaomi_santoni.git -b nad-11 vendor/xiaomi/

echo "Cloning toolchain..."
git clone https://github.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-6875598 --depth=1 prebuilts/clang/host/linux-x86/clang-r399163b

echo "Setting up ccache..."
export USE_CCACHE=1
ccache -M 150G

echo "fixing hals..."
rm -rvf hardware/qcom-caf/msm8996/audio
rm -rvf hardware/qcom-caf/msm8996/display
rm -rvf hardware/qcom-caf/msm8996/media
rm -rvf vendor/qcom/opensource/display-commonsys-intf
rm -rvf hardware/qcom-caf/wlan
git clone https://github.com/Jabiyeff/android_hardware_qcom_audio -b lineage-18.0-caf-msm8996 hardware/qcom-caf/msm8996/audio
git clone https://github.com/Jabiyeff/android_hardware_qcom_display -b caf-msm8996-r hardware/qcom-caf/msm8996/display
git clone https://github.com/Jabiyeff/android_hardware_qcom_media -b caf-msm8996-r hardware/qcom-caf/msm8996/media
git clone https://github.com/Jabiyeff/android_hardware_qcom_display -b R-commonsys-intf vendor/qcom/opensource/display-commonsys-intf
git clone https://github.com/Jabiyeff/android_hardware_qcom-caf_wlan -b LA.UM.9.6.2.r1 hardware/qcom-caf/wlan

echo "cloning sepolicy from lineage..."
rm -rvf device/qcom/sepolicy-legacy-um
rm -rvf system/bt
git clone https://github.com/Jabiyeff/android_device_qcom_sepolicy -b lineage-18.0-legacy-um device/qcom/sepolicy-legacy-um
git clone https://github.com/Jabiyeff/android_system_bt -b lineage-18.0 system/bt

echo "building rom..."
. build/envsetup.sh
