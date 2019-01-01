Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0957C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64412080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfAAKWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 05:22:31 -0500
Received: from mail78-59.sinamail.sina.com.cn ([219.142.78.59]:49606 "HELO
        mail78-59.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1728195AbfAAKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 05:22:31 -0500
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jan 2019 05:22:31 EST
Received: from unknown (HELO MiWiFi-R3-srv.localdomain)([171.223.33.27])
        by sina.com with ESMTP
        id 5C2B3D230000D246; Tue, 1 Jan 2019 18:12:53 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 162339393338
From:   Peng Hao <penghao122@sina.com.cn>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  misc/sgi-gru/grufault: fix a style error
Date:   Tue,  1 Jan 2019 18:12:47 +0800
Message-Id: <1546337567-14692-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

Fix a style error. Remove redundant space.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/sgi-gru/grufault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 93be82f..2ec5808 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -616,8 +616,8 @@ irqreturn_t gru_intr_mblade(int irq, void *dev_id)
 	for_each_possible_blade(blade) {
 		if (uv_blade_nr_possible_cpus(blade))
 			continue;
-		 gru_intr(0, blade);
-		 gru_intr(1, blade);
+		gru_intr(0, blade);
+		gru_intr(1, blade);
 	}
 	return IRQ_HANDLED;
 }
-- 
1.8.3.1


