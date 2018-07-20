Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078BEECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B653A204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B653A204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeGTPTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:19:49 -0400
Received: from mout.perfora.net ([74.208.4.197]:45721 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731336AbeGTPTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:19:48 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LwHJA-1g67lP3R2k-0185va; Fri, 20 Jul 2018 16:30:50 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Gilbert <benjamin.gilbert@coreos.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 6/6] ARM: defconfig: tegra: enable tegra raw nand driver
Date:   Fri, 20 Jul 2018 16:30:12 +0200
Message-Id: <20180720143012.7740-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720143012.7740-1-marcel@ziswiler.com>
References: <20180720143012.7740-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:VuX1QxYreuZU3BfK+Jmfcf/99oF4tYaBtTLtlWlYbCsfcMjs04v
 AMN7Iz5uSQbzLENyJ4viA1wEUWGaAzC4aW8c7cFP/1Htdii3FMeYBMeHx/AaH7wTukXmVvB
 rsOoriWgm849z+C6nMzBqwNOupKUrt2SjIrvYwfczuAD9zLbt3FjjNpodqvGncwZr0vXxCA
 Cqm7E165wH5q6+JD5rmCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UyAVt37YMUA=:aFzYAJlTfph5kqomE2Lxs1
 4PbgwE575SOIneGw+9sjx/LRQlUSE44+eLPMbe45cvXVqb1Rwe2uLARUuXtqx2FMm1cwwA8QI
 116x7qB4eWOHmAexzWlarl5rGaB+9vMLL3KRBuRPMriodTN4cDy9TWb3kOlrJ253gx3RWpton
 UWwsI8AmgjT8wvELE2z7UN2c+n0XilsrqSrvYgLglj2TrRXB5nUus+1aSVZFk7HPqpemjJRS5
 skmI7owDxbYrVuVHVhdowHU8UT0gmeBFJCh9u6tMZX6VbTFWp0mDaOcL/PV4V4nFDIwrxueJE
 wZQM5XE5fdC7RCxJ0qeZpYniwByfUzx2OKWW+1H6qT/HeRoft2lzUAi8rOfOWToQ6Vwn9gPsp
 iWBOFaNDzfOhsGDhCJZknTf+n1rvL7faIVqzjHKfZvCX8+I6ufCyEghcZ0JCJK4Du8ezRkJBF
 Da4Bczb0YtMtIPJtxxTfWVueHevrqrTnecteS+IXrmJpnR3gz2bfl6glgPBjnpUFtuQUNkirx
 N6vA527MVZPsmmJ1H+mBb2LBmC77pbUpFciCfrDwIp4lNj9jWOCII3yLe3UgoTwl3oAr+/MoU
 J1IycXxnBgUKfIVlJrtCjLfKc5k9LshvBT7QS/Vd81F+3zUsBtFSYJRcOHlowWWAlVBI8THLU
 J2woGNg6yKSuYoRSFAG1FaXEjC46iS0fmgdcXHJYFPq0+2gpLPS0J/dSOTrsE6NkIZH0=
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

