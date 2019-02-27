Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F53C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7E9218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfB0ExS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:53:18 -0500
Received: from mx.socionext.com ([202.248.49.38]:31055 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbfB0ExS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 23:53:18 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Feb 2019 13:53:16 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 45DB6180D46;
        Wed, 27 Feb 2019 13:53:16 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 27 Feb 2019 13:53:16 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id B27D940392;
        Wed, 27 Feb 2019 13:53:15 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 8ECC1121B6C;
        Wed, 27 Feb 2019 13:53:15 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v4 09/10] ARM: configs: Add Milbeaut M10V defconfig
Date:   Wed, 27 Feb 2019 13:53:52 +0900
Message-Id: <1551243232-10902-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the minimal defconfig for the Milbeaut M10V.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/configs/milbeaut_m10v_defconfig | 119 +++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 arch/arm/configs/milbeaut_m10v_defconfig

diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
new file mode 100644
index 0000000..7c07f98
--- /dev/null
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -0,0 +1,119 @@
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CGROUPS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+CONFIG_ARCH_MILBEAUT=y
+CONFIG_ARCH_MILBEAUT_M10V=y
+CONFIG_ARM_THUMBEE=y
+# CONFIG_VDSO is not set
+# CONFIG_CACHE_L2X0 is not set
+CONFIG_ARM_ERRATA_430973=y
+CONFIG_ARM_ERRATA_720789=y
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_ARM_ERRATA_754327=y
+CONFIG_ARM_ERRATA_764369=y
+CONFIG_ARM_ERRATA_775420=y
+CONFIG_ARM_ERRATA_798181=y
+CONFIG_SMP=y
+# CONFIG_SMP_ON_UP is not set
+# CONFIG_ARM_CPU_TOPOLOGY is not set
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_NR_CPUS=16
+CONFIG_THUMB2_KERNEL=y
+# CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11 is not set
+# CONFIG_ARM_PATCH_IDIV is not set
+CONFIG_HIGHMEM=y
+CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_SECCOMP=y
+CONFIG_KEXEC=y
+CONFIG_EFI=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=m
+CONFIG_CPU_FREQ_GOV_USERSPACE=m
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
+CONFIG_CPUFREQ_DT=y
+CONFIG_QORIQ_CPUFREQ=y
+CONFIG_CPU_IDLE=y
+CONFIG_ARM_CPUIDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_KERNEL_MODE_NEON=y
+CONFIG_EFI_VARS=m
+CONFIG_EFI_CAPSULE_LOADER=m
+CONFIG_ARM_CRYPTO=y
+CONFIG_CRYPTO_SHA1_ARM_NEON=m
+CONFIG_CRYPTO_SHA1_ARM_CE=m
+CONFIG_CRYPTO_SHA2_ARM_CE=m
+CONFIG_CRYPTO_SHA512_ARM=m
+CONFIG_CRYPTO_AES_ARM=m
+CONFIG_CRYPTO_AES_ARM_BS=m
+CONFIG_CRYPTO_AES_ARM_CE=m
+CONFIG_CRYPTO_GHASH_ARM_CE=m
+CONFIG_CRYPTO_CRC32_ARM_CE=m
+CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMDLINE_PARTITION=y
+CONFIG_CMA=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=64
+CONFIG_OF_OVERLAY=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_SRAM=y
+CONFIG_INPUT_FF_MEMLESS=m
+CONFIG_INPUT_MATRIXKMAP=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_SERIAL_DEV_BUS=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
+# CONFIG_HWMON is not set
+CONFIG_MEDIA_SUPPORT=m
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_SYNC_FILE=y
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_SOC_BRCMSTB=y
+CONFIG_MEMORY=y
+# CONFIG_ARM_PMU is not set
+CONFIG_EXT4_FS=y
+CONFIG_AUTOFS4_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CONFIGFS_FS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
+CONFIG_KEYS=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
+CONFIG_CRYPTO_SEQIV=m
+# CONFIG_CRYPTO_ECHAINIV is not set
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_CCITT=m
+CONFIG_CRC_ITU_T=m
+CONFIG_PRINTK_TIME=y
+CONFIG_MAGIC_SYSRQ=y
-- 
1.9.1

