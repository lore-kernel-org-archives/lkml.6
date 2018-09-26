Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F67C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A015B20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A015B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeIZTSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:18:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZTSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:18:22 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MKMIR-1gKu2S301f-00LniG; Wed, 26 Sep 2018 15:05:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: ixp4xx: include linux/mtd/platnand.h
Date:   Wed, 26 Sep 2018 15:04:39 +0200
Message-Id: <20180926130458.2406549-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926130458.2406549-1-arnd@arndb.de>
References: <20180926130458.2406549-1-arnd@arndb.de>
X-Provags-ID: V03:K1:eesi5L5oJRNUXfWq2ccLh2og1C9GMWU0FkGZdoVipVyHPt9fW6w
 oE+VoAxq4XVMNQhPapgsIuxwuQ15b1HTAglY0QXFnOgxP90+tFx3CGH0SS4n7Pz/p85zNrM
 IqJ0UO7TGIlZ7nOjyCgS/aK425+HK3xeHJiRwzUgC2GxNYz5inTgmJdpNrVoFgbAmG/YpA6
 yDcPpnrrrsmggcCzaeuMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ukSRywdMagk=:g7NFJP+1r1caKMiUdvVi65
 sG3r4fvXv41d+ydIZ4fBCDElVgCjd4bPMHcpkEpX9AWYRw3HdWzO9mM8ZMhhOfRAduXHbvGwT
 dQku4losMvxTCGri5phxYo5iBx7BjhnClLBpg1cqTkKpcUdUzTvP36AXzQChDqO82cGdY9Dyu
 j9GCINTDVCAuy5RYW2vSI25QP+dhUsHobhMIL552/ATD/fkGza4npXTUPgoWmQBV8T7Vn65/v
 L3MdcQ9i1KTLUIyxSeDZS9dM7FsC2TYEdBpZWdhP5aQxPDWzV2VfvTjkj/qV4KXH+lkwbMGba
 QTX+SAeuWJZ09Yl+OV3Yxs1fBTgD8AZVhI6vzVLGEMWw2jJy1h/Iz2QQzEUfFUa632CDJiWxz
 SJag5CkqWQF5ygL2+vd9aBaRH+7cIMt2nWKuhil8aTErbskV8DqFVhfZjcYDaSvIMWU/WeBI3
 DmhSOaP/raY+YAYEGoCdmzvs6BAeC/GfNpDg9CB9RHuAhuzEzhqQkSPRqWRdRDQ6YBIKTTxdC
 P+lZnMayJYk/846SWZmxItuV863D54xp/9GcTiCsSVSk6WbDxQoe3N6PYgoZec2HOpisBVuw/
 zYuhFWZe+6mXDVFlyfKlpQhymvgKs812aXiwDRoeZbyySOhpcvzbg0N5mQY0cRkjl+HfuuUeN
 MLhIW6cuN19Gm7AGQxrTr85lvWMk2o1Rx4OxY26Dl0xPm+t1hYcthm3Wm4AAPcejUzgk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_nand_data structure definition is required for ixdp425
but has now moved to a new header file:

arch/arm/mach-ixp4xx/ixdp425-setup.c:98:15: error: variable 'ixdp425_flash_nand_data' has initializer but incomplete type
 static struct platform_nand_data ixdp425_flash_nand_data = {
               ^~~~~~~~~~~~~~~~~~
arch/arm/mach-ixp4xx/ixdp425-setup.c:99:3: error: 'struct platform_nand_data' has no member named 'chip'

Fixes: 19cf5dfa3a31 ("mtd: rawnand: Move platform_nand_xxx definitions out of rawnand.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/ixdp425-setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 797e7edc7124..57d7df79d838 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -20,6 +20,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <asm/types.h>
-- 
2.18.0

