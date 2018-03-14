Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeCNIfw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:35:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56259 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeCNIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:35:51 -0400
X-Google-Smtp-Source: AG47ELv9Zc1jFBnjdGVeoyYVVN1I1D9DOUOUVzOAVxoNbEFDIUjFXmk4marNS6/7P1s5We89xawNLw==
From: Neil Armstrong <narmstrong@baylibre.com>
To: arm@kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        linux-oxnas@lists.tuxfamily.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: configs: add OXNAS v6 defconfig
Date: Wed, 14 Mar 2018 09:35:44 +0100
Message-Id: <1521016544-16562-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs adds the minimal defconfig for the OXNAS ARMv6 SoCs
including the OX820 SoC and needed minimal configurations.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---

Hi Arnds,

Can you take this directly ? It will avoid send a pull request for a single patch..
This defconfig will help adding the ox820 to a kernelci lab for testing.

Thanks,
Neil

 arch/arm/configs/oxnas_v6_defconfig | 93 +++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 arch/arm/configs/oxnas_v6_defconfig

diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/oxnas_v6_defconfig
new file mode 100644
index 0000000..f6ba32c
--- /dev/null
+++ b/arch/arm/configs/oxnas_v6_defconfig
@@ -0,0 +1,93 @@
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CGROUPS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+CONFIG_STRICT_KERNEL_RWX=y
+CONFIG_STRICT_MODULE_RWX=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMDLINE_PARTITION=y
+CONFIG_ARCH_MULTI_V6=y
+CONFIG_ARCH_OXNAS=y
+CONFIG_MACH_OX820=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_CMA=y
+CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_SECCOMP=y
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_KEXEC=y
+CONFIG_EFI=y
+CONFIG_CPU_IDLE=y
+CONFIG_ARM_CPUIDLE=y
+CONFIG_VFP=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_IPV6_OPTIMISTIC_DAD=y
+CONFIG_INET6_AH=m
+CONFIG_INET6_ESP=m
+CONFIG_INET6_IPCOMP=m
+CONFIG_IPV6_MIP6=m
+CONFIG_IPV6_TUNNEL=m
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_OXNAS=y
+CONFIG_MTD_UBI=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_NETDEVICES=y
+CONFIG_STMMAC_ETH=y
+CONFIG_REALTEK_PHY=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_CLASS_FLASH=m
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_ARM_TIMER_SP804=y
+CONFIG_EXT4_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_UBIFS_FS=y
+CONFIG_PSTORE=y
+CONFIG_PSTORE_CONSOLE=y
+CONFIG_PSTORE_PMSG=y
+CONFIG_PSTORE_RAM=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
+CONFIG_PRINTK_TIME=y
+CONFIG_MAGIC_SYSRQ=y
-- 
2.7.4
