Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A5FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BCE20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BCE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbeGXIv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:51:59 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:34028 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388424AbeGXIv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:51:59 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id EXml1y00M3XaVaC01XmlUb; Tue, 24 Jul 2018 09:46:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fhs1t-0003TG-Dt; Tue, 24 Jul 2018 09:46:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fhs1t-00070c-C8; Tue, 24 Jul 2018 09:46:45 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/defconfig: Update defconfigs for v4.18-rc6
Date:   Tue, 24 Jul 2018 09:46:44 +0200
Message-Id: <20180724074644.26901-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be merged with "m68k/defconfig: Update defconfigs for v4.18-rc1"
---
 arch/m68k/configs/amiga_defconfig    | 4 +---
 arch/m68k/configs/apollo_defconfig   | 4 +---
 arch/m68k/configs/atari_defconfig    | 4 +---
 arch/m68k/configs/bvme6000_defconfig | 4 +---
 arch/m68k/configs/hp300_defconfig    | 4 +---
 arch/m68k/configs/mac_defconfig      | 4 +---
 arch/m68k/configs/multi_defconfig    | 4 +---
 arch/m68k/configs/mvme147_defconfig  | 4 +---
 arch/m68k/configs/mvme16x_defconfig  | 4 +---
 arch/m68k/configs/q40_defconfig      | 4 +---
 arch/m68k/configs/sun3_defconfig     | 4 +---
 arch/m68k/configs/sun3x_defconfig    | 4 +---
 12 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 6c4ba2cc94ddb14f..1d5483f6e457b0a0 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -99,14 +99,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index b8b40042d8516a32..52a0af127951f5f0 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -97,14 +97,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 2de40b307a0ba624..b9473c6e7dbaaf5e 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -97,14 +97,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index dc9163eb49170f3e..fb7d651a4cabe203 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -95,14 +95,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 24685d6021e777d1..6b37f5537c3905c5 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -97,14 +97,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 9175d9a705545b3e..c717bf8794492114 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -96,14 +96,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 90d40974d6482d7a..226c994ce794f6ac 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -106,14 +106,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 21cf1c482d5174df..b383327fd77a9411 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -94,14 +94,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 0fe8373f1d232741..9783d3deb9e9d852 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -95,14 +95,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 5d35b4dd1bc8d899..a35d10ee10cb709b 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -95,14 +95,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 17909bf6816baf90..573bf922d44823b7 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -92,14 +92,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 4f60a1efb3da5ad4..efb27a7fcc559d5b 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -92,14 +92,12 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_SET=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_SET_RBTREE=m
-CONFIG_NFT_SET_HASH=m
-CONFIG_NFT_SET_BITMAP=m
 CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
-- 
2.17.1

