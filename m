Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B190AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C3E2174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C3E2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeHCKaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:30:01 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:51468 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbeHCKaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:30:01 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id F39785A06B03ED5BC90E;
        Fri,  3 Aug 2018 16:34:44 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w738YZJi047213;
        Fri, 3 Aug 2018 16:34:35 +0800 (GMT-8)
        (envelope-from huang.chong@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018080316344410-3116719 ;
          Fri, 3 Aug 2018 16:34:44 +0800 
From:   Huang Chong <huang.chong@zte.com.cn>
To:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        huang.chong@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH] xfs: fix a comment in xfs_log_reserve
Date:   Fri, 3 Aug 2018 16:31:33 +0800
Message-Id: <1533285093-193140-1-git-send-email-huang.chong@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-03 16:34:44,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-03 16:34:20,
        Serialize complete at 2018-08-03 16:34:20
X-MAIL: mse01.zte.com.cn w738YZJi047213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Huang Chong" <huang.chong@zte.com.cn>

Fix the comment in xfs_log_reserve to avoid confusing.

Signed-of-by: Huang Chong <huang.chong@zte.com.cn>
---
 fs/xfs/xfs_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 5e56f3b..891ffb1 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -410,7 +410,7 @@
 }
 
 /*
- * Reserve log space and return a ticket corresponding the reservation.
+ * Reserve log space and return a ticket corresponding to the reservation.
  *
  * Each reservation is going to reserve extra space for a log record header.
  * When writes happen to the on-disk log, we don't subtract the length of the
-- 
1.8.3.1

