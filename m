Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A2C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A9D2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A9D2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbeHNQyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:54:43 -0400
Received: from mout.perfora.net ([74.208.4.197]:59967 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732672AbeHNQym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:54:42 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MFabr-1fdjzQ0We5-00EaZt; Tue, 14 Aug 2018 16:06:49 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Gilbert <benjamin.gilbert@coreos.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [RESEND PATCH 6/6] ARM: defconfig: tegra: enable tegra raw nand driver
Date:   Tue, 14 Aug 2018 16:06:12 +0200
Message-Id: <20180814140612.12554-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180814140612.12554-1-marcel@ziswiler.com>
References: <20180814140612.12554-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:aM8eErqe+rdm0c0gIG7LO1tR4HKgnjrlX26LECEziALOOYuZn6M
 XHc9biyjbsHqW4Gfa04rkcd0FqiudHk6S2UJSWGnd9sN6KWmxKl5C5RlT9k3XO1NxUeyFGK
 SdHAJFOrbzogIdwYKd1jHVIRxQzDSEftXZ1FDR3eON5flp+jvv/HucPKQi9A7gOaAB5sgiZ
 Zvw6XCLoV1NvVEk5EMBOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7pAbZGyh98U=:SrUh+J7LBA0XEMp3+Mh/Rh
 bUJ6Y44wtFsrM3W/OOFtchQJ07D6leW9f11jNq0P20KZ8zx6fl1lPKNTz8Tug6JMTQeMHT+oD
 niXUlzsvJXqFjDwsVG4H/oN7/xsjAzgzBL6VGUPkAIOUjQpTcjC1UsKdIiWQw10HCQCUQo/XB
 CNigIqjNJxUwzCjCZWCJdQNjmpprjs6xzU8d1gL13guXhNGoyNs4EBVnOpgdWGcZBjfSXlCee
 j/YhVMtT6Nn95S+OLeOXLmYmAba8ix8g44McGl3fm7GerkEN/Eb9mTgEpOj0zmDd+Kq/CDnxR
 i2hGu54guaYL40pM66Q4BxTC1c8G13IW+TYZEbSxEQ6sPyRRzEsSO7aBjgTQ7eqnF0ZeGxq/p
 TkdXWwLJpAAPWGOY7G+kpyRAmwtz85PJnnfEYqkki1Sz/XkSb2H2Cb7EsqSckxDi56t+ea+FR
 mraExgZDuPlgzhc8VkUvXp0vhafDSvXK7SFfeit+r+t5jNoXEV3U5VjZ4iyUSC5CMx+bJd1ye
 I7fNd3YPVKSDClLf5w1Xs53tJrLimAIcLoqF+/mdOMQYKMLnUWUqHPFbHQSu1LTRGzfoqEkL4
 tewdch+S4TDi0FkDmdHWi7ZyQX3ecivF4BUmtGoc57aeZMRNifa6PiKBThluX35CSEz1ePqxR
 QpTMGqEJTUy2hZo3oMh8SPfjts0sultUOtOfbQiSmf32tXF/U9Pje0WdqvrturhLToJ0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Now with everything being merged actually enable it. Also enable
MTD_OF_PARTS, MTD_BLOCK, MTD_NAND, MTD_UBI and UBIFS without which
the former would not make much sense and is also in-line with
multi_v7_defconfig.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/tegra_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 24e297659b55..b248e231900f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -79,8 +79,13 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_TEGRA_GMI=y
 CONFIG_MTD=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_TEGRA=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_AD525X_DPOT=y
 CONFIG_AD525X_DPOT_I2C=y
@@ -280,6 +285,7 @@ CONFIG_EXT3_FS_SECURITY=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_UBIFS_FS=y
 CONFIG_SQUASHFS=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_SQUASHFS_XZ=y
-- 
2.14.4

