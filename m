Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72351C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3132C240E4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3132C240E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeGELaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:30:13 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:35040 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753943AbeGELaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:30:12 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w65BRqIS013586;
        Thu, 5 Jul 2018 14:27:52 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 8441)
        id 59F5562E17; Thu,  5 Jul 2018 14:27:52 +0300 (IDT)
From:   avifishman70@gmail.com
To:     davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc:     rdunlap@infradead.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Avi Fishman <AviFishman70@gmail.com>
Subject: [PATCH v3 1/1] MAINTAINERS: add subfolders for nuvoton *npcm*
Date:   Thu,  5 Jul 2018 14:27:50 +0300
Message-Id: <20180705112750.197458-2-avifishman70@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705112750.197458-1-avifishman70@gmail.com>
References: <20180705112750.197458-1-avifishman70@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <AviFishman70@gmail.com>

Add several subfolders to look for *npcm* files under
ARM/NUVOTON NPCM ARCHITECTURE

Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ce3c5f32e5..dbe3ce376dfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1727,7 +1727,9 @@ F:	arch/arm/mach-npcm/
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
 F:	drivers/*/*npcm*
-F:	Documentation/*/*npcm*
+F:	drivers/*/*/*npcm*
+F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/*/*/*npcm*
 
 ARM/NUVOTON W90X900 ARM ARCHITECTURE
 M:	Wan ZongShun <mcuos.com@gmail.com>
-- 
2.14.1

