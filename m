Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D13216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D13216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeI0VHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:07:14 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58702 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727335AbeI0VHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:07:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1580389|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07408;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CwbSxYw_1538059703;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwbSxYw_1538059703)
          by smtp.aliyun-inc.com(10.147.40.2);
          Thu, 27 Sep 2018 22:48:23 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 02/33] csky: defconfig
Date:   Thu, 27 Sep 2018 22:47:39 +0800
Message-Id: <bd032dd6ed9c1652e747b4f6f164fbbeb4c64265.1538058840.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds csky defconfig.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/configs/defconfig | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 arch/csky/configs/defconfig

diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
new file mode 100644
index 0000000..7ef4289
--- /dev/null
+++ b/arch/csky/configs/defconfig
@@ -0,0 +1,61 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="csky"
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
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
+CONFIG_EXT4_FS=y
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
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
-- 
2.7.4

