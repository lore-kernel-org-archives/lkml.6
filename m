Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_75_100,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA99C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D87220658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D87220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIEQiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:38:23 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33432 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbeIEQiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:38:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1720013|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CmtHaCX_1536149292;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CmtHaCX_1536149292)
          by smtp.aliyun-inc.com(10.147.40.7);
          Wed, 05 Sep 2018 20:08:12 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de
Cc:     c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com,
        green.hu@gmail.com
Subject: [PATCH V3 02/26] csky: defconfig
Date:   Wed,  5 Sep 2018 20:07:41 +0800
Message-Id: <dc7a52f2c2571a85c87e163d49cecddd3c2f2430.1536138304.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/configs/defconfig | 76 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 arch/csky/configs/defconfig

diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
new file mode 100644
index 0000000..c6a5a40
--- /dev/null
+++ b/arch/csky/configs/defconfig
@@ -0,0 +1,76 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="csky"
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_USELIB=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_RELAY=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_USERFAULTFD=y
+CONFIG_EMBEDDED=y
+CONFIG_PROFILING=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_BLK_DEV_INTEGRITY=y
+CONFIG_DEFAULT_DEADLINE=y
+CONFIG_CPU_CK807=y
+CONFIG_CPU_HAS_FPU=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_TTY_PRINTK=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_CSKY_MPTIMER=y
+CONFIG_GX6605S_TIMER=y
+CONFIG_PM_DEVFREQ=y
+CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
+CONFIG_DEVFREQ_GOV_PERFORMANCE=y
+CONFIG_DEVFREQ_GOV_POWERSAVE=y
+CONFIG_DEVFREQ_GOV_USERSPACE=y
+CONFIG_GENERIC_PHY=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_FANOTIFY=y
+CONFIG_QUOTA=y
+CONFIG_FSCACHE=m
+CONFIG_FSCACHE_STATS=y
+CONFIG_CACHEFILES=m
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_UTF8=y
+CONFIG_NTFS_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_CHILDREN=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_CRAMFS=y
+CONFIG_ROMFS_FS=y
+CONFIG_NFS_FS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_UNUSED_SYMBOLS=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
-- 
2.7.4

