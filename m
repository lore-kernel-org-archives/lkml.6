Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB80BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAAE208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAAE208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeGMN4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:56:21 -0400
Received: from mout.web.de ([217.72.192.78]:57489 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729284AbeGMN4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:56:21 -0400
Received: from lab-pc04.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M4ZPc-1fyoWE0kH6-00ye8O; Fri, 13 Jul 2018 15:41:14 +0200
From:   =?UTF-8?q?Oliver=20H=C3=BCbers?= <oliver.huebers@web.de>
To:     gregkh@linuxfoundation.org
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@i4.cs.fau.de,
        =?UTF-8?q?Oliver=20H=C3=BCbers?= <oliver.huebers@web.de>,
        Vanessa Borgmann <nessa.x@web.de>
Subject: [PATCH 1/4] staging: mt7621-pci: Include preferred headers
Date:   Fri, 13 Jul 2018 15:41:03 +0200
Message-Id: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XdwZdVK978Pvi1wtfc8OagyUHXfYMwEETYbIxa2nRG5ZBICqBCt
 mdGTY0TPCU5dvUVPD96VxAG8clyNnsH/i66Mz4OxoYfb7yJKJw4rUMhIb25BNa7XiCpq4hv
 cI0ChZkdtd1NsCzs5fF+LtuI0UGMyFLocTeWXPovafx4bWFBcgxiTztaqYc6vNljkj0fTl5
 gIuLVZOovD1FwYEbAUB1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vRsBYdBoU3s=:O/WEysU/vI/2Bq9CS6AQsw
 qY6A10h/nBpm3YYAD6A0TohUnUJdhA2nL64KfjA4Xb/PNHbFI8Fw0cTqv1wsiQ+2LpmTRknbB
 aoC6EgyVeI+i7TpXKaIfm7hVYOCCUaOxANPj9Afs15cVzbrUx7Qa4bjWeqHhZWUUu8qEUbyl5
 SpiLKAX6Zniu+HO1Y4OocV01kIXSPfR5n0pcxUylgUfeeR1LFsKRnDf9kBHfbpkyfEQxtFzBZ
 zvWtOBCmEzRCDmFlLzOQtBbWmoSAgPwN3LCDgzk1b5MnMXllyRFd8dLCsE6soJzj1e2Ryn/b7
 gnsirKJBIKfRpxO7zkRKUgS4p3jAvcpgjC9vqlSJxLpnQjVaIwG4SWjjJujohYqG74L8J8xC+
 hRXKUQkAM1+8y1kp+zekDg0Wxfg8A/ZrJs8bKULVj0X79PL01y5RubhAEqSugSVsajIvrNr82
 dAQzaqYVEQaQixAwJbiqCuNfFqhhz7J36+Z/3bdzygz0U7Taudo9S3SaDeAkRqgBdX1n2FkO/
 HancdreQ70OX4Kr4men30/FL/jNj1bjAk2AO6q0sSZFzaXkZLCWHrr7qbrlqaKAiZmWsV4v1p
 0S9gGLuSWK+TIAV2oXQx2ze8GX55Jqemikw5xot0pvs3rWO8msPWMJHo7LnXjqvez+0bWxNWe
 asfHuUVubm2FZX/Fbn7N70X0Dke3h3L0OzSf5a/wqxlkyib5UWbfd6f8P+Et97o7Bu3YTw9OT
 KZghvGIAYfsocUuIO/fwjz353yxJWpNS69JdoOFs1sp+SFfnDnJAfCdbaWlzXtq1tw/CQLrmy
 IsodJLe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch warnings:
Use #include <linux/pci.h> instead of <asm/pci.h>
Use #include <linux/io.h> instead of <asm/io.h>

Signed-off-by: Oliver Hübers <oliver.huebers@web.de>
Signed-off-by: Vanessa Borgmann <nessa.x@web.de>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 4f56840..e092b5d 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -44,8 +44,8 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/version.h>
-#include <asm/pci.h>
-#include <asm/io.h>
+#include <linux/pci.h>
+#include <linux/io.h>
 #include <asm/mips-cm.h>
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.7.4

