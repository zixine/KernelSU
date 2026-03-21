#!/bin/bash

# Kita ubah variabel ini menjadi zixine dan zixinesu
word1="com"
word2="zixine"
word3="zixinesu"

# Export variables for use in find -exec
export word1 word2 word3

# Rename directories (mengubah struktur folder app)
find . -depth -type d -name 'me' -execdir mv {} "$word1" \;
find . -depth -type d -name 'weishu' -execdir mv {} "$word2" \;
find . -depth -type d -name 'kernelsu' -execdir mv {} "$word3" \;

# Replace inside files (mengubah referensi package di dalam semua file)
find . -type f -exec sed -i \
    -e "s/me\.weishu\.kernelsu/$word1.$word2.$word3/g" \
    -e "s/me\/weishu\/kernelsu/$word1\/$word2\/$word3/g" \
    -e "s/me_weishu_kernelsu/${word1}_${word2}_${word3}/g" {} +

# Mengubah nama file APK yang dihasilkan saat di-build
if [ -f "./app/build.gradle.kts" ]; then
    # Jika sebelumnya bernama KernelSU
    sed -i 's/outputFileName = "KernelSU_${managerVersionName}_${managerVersionCode}-\$name.apk"/outputFileName = "ZixineSu_${managerVersionName}_${managerVersionCode}-\$name.apk"/' ./app/build.gradle.kts
    # Jika sebelumnya bernama MamboSU
    sed -i 's/outputFileName = "MamboSU_${managerVersionName}_${managerVersionCode}-\$name.apk"/outputFileName = "ZixineSu_${managerVersionName}_${managerVersionCode}-\$name.apk"/' ./app/build.gradle.kts
fi

echo "Done. Berhasil mengubah menjadi ZixineSu."
