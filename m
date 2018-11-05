Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503B6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6092086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6092086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeKESns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:43:48 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:41018 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:43:43 -0500
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id w9Qu1y00R3XaVaC019QuoC; Mon, 05 Nov 2018 10:24:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gJb7u-0001MD-Fo; Mon, 05 Nov 2018 10:24:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gJaGD-0005bo-S4; Mon, 05 Nov 2018 09:29:25 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/defconfig: Update defconfigs for v4.20-rc1
Date:   Mon,  5 Nov 2018 09:29:22 +0100
Message-Id: <20181105082922.21519-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/configs/amiga_defconfig    | 4 ++++
 arch/m68k/configs/apollo_defconfig   | 4 ++++
 arch/m68k/configs/atari_defconfig    | 4 ++++
 arch/m68k/configs/bvme6000_defconfig | 4 ++++
 arch/m68k/configs/hp300_defconfig    | 4 ++++
 arch/m68k/configs/mac_defconfig      | 4 ++++
 arch/m68k/configs/multi_defconfig    | 4 ++++
 arch/m68k/configs/mvme147_defconfig  | 4 ++++
 arch/m68k/configs/mvme16x_defconfig  | 4 ++++
 arch/m68k/configs/q40_defconfig      | 4 ++++
 arch/m68k/configs/sun3_defconfig     | 4 ++++
 arch/m68k/configs/sun3x_defconfig    | 4 ++++
 12 files changed, 48 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 8970880ef0a0eeed..50d1a91659a481c3 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -124,6 +124,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -576,6 +577,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -634,6 +636,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -646,4 +649,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 815a0ba131b91eb4..3afbc0ae28c38d93 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -120,6 +120,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -536,6 +537,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -594,6 +596,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -606,4 +609,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 36dd917b74f54954..7dfd6f0844a95936 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -127,6 +127,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -569,6 +570,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -628,6 +630,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -640,4 +643,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 7e8547a455a2c5ed..bd9f4416225ffe00 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -117,6 +117,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -529,6 +530,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -587,6 +589,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -599,4 +602,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 8071cd1c8e4b52a1..7929afc8b55e89be 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -119,6 +119,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -538,6 +539,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -596,6 +598,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -608,4 +611,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 95f6c571670ba7ec..ec52408c7c31eb23 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -118,6 +118,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -560,6 +561,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -618,6 +620,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -630,4 +633,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index a66dffc08cd01c40..47370b1114ef15e9 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -138,6 +138,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -642,6 +643,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -700,6 +702,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -712,4 +715,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 8e8030ec6896bcb7..2d037d508bc4abcd 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -116,6 +116,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -528,6 +529,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -586,6 +588,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -598,4 +601,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index f82b54934b175047..6c152ddeae8746c2 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -117,6 +117,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -529,6 +530,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -587,6 +589,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -599,4 +602,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 882b603670529613..bda949aa5f86cc92 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -118,6 +118,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -547,6 +548,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -605,6 +607,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -617,4 +620,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index feb425d2b0e0f6d6..2315b2eec507b82f 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -114,6 +114,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -531,6 +532,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -589,6 +591,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -601,3 +604,4 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 1a0e8199e1153cd5..f5fae56ccd41e947 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -114,6 +114,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_XFRM=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_OSF=m
 CONFIG_NFT_TPROXY=m
@@ -530,6 +531,7 @@ CONFIG_CRYPTO_MORUS640=m
 CONFIG_CRYPTO_MORUS1280=m
 CONFIG_CRYPTO_CFB=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_XCBC=m
@@ -588,6 +590,7 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITFIELD=m
 CONFIG_TEST_UUID=m
+CONFIG_TEST_XARRAY=m
 CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
@@ -600,4 +603,5 @@ CONFIG_TEST_SYSCTL=m
 CONFIG_TEST_UDELAY=m
 CONFIG_TEST_STATIC_KEYS=m
 CONFIG_TEST_KMOD=m
+CONFIG_TEST_MEMCAT_P=m
 CONFIG_EARLY_PRINTK=y
-- 
2.17.1

