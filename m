Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DBAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787A7214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeL0GFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 01:05:39 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:36660 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbeL0GFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 01:05:39 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 8BA01C18A26A0155A9CE;
        Thu, 27 Dec 2018 14:05:37 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBR65R8r021644;
        Thu, 27 Dec 2018 14:05:27 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122714055608-19047492 ;
          Thu, 27 Dec 2018 14:05:56 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  arm/mm/pmsa-v8 : remove unneeded semicolon
Date:   Thu, 27 Dec 2018 14:26:21 +0800
Message-Id: <1545891981-84215-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-27 14:05:56,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-27 14:05:15,
        Serialize complete at 2018-12-27 14:05:15
X-MAIL: mse01.zte.com.cn wBR65R8r021644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded semicolon.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm/mm/pmsa-v8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/pmsa-v8.c b/arch/arm/mm/pmsa-v8.c
index 617a83d..0d7d5fb 100644
--- a/arch/arm/mm/pmsa-v8.c
+++ b/arch/arm/mm/pmsa-v8.c
@@ -165,7 +165,7 @@ static int __init pmsav8_setup_ram(unsigned int number, phys_addr_t start,phys_a
 		return -EINVAL;
 
 	bar = start;
-	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
 
 	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED;
 	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN;
@@ -181,7 +181,7 @@ static int __init pmsav8_setup_io(unsigned int number, phys_addr_t start,phys_ad
 		return -EINVAL;
 
 	bar = start;
-	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
 
 	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED | PMSAv8_BAR_XN;
 	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_DEVICE_nGnRnE) | PMSAv8_LAR_EN;
-- 
1.8.3.1

