Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DC5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F68F2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F68F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeKGQpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:45:42 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:29048 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeKGQpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 11:45:41 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 387EA9D6462EDC53C1B0;
        Wed,  7 Nov 2018 15:16:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA77GU2P043284;
        Wed, 7 Nov 2018 15:16:30 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110715164720-9145166 ;
          Wed, 7 Nov 2018 15:16:47 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  arm64: fix commit style in the comments
Date:   Wed, 7 Nov 2018 23:39:11 +0800
Message-Id: <1541605151-6757-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-07 15:16:47,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-07 15:16:22,
        Serialize complete at 2018-11-07 15:16:22
X-MAIL: mse01.zte.com.cn wA77GU2P043284
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use git commit description style 'commit <12+ chars of sha1>
("<title line>")' in the comments.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm64/kernel/sys32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 0f8bcb7..8317a5a 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -40,8 +40,8 @@
 	 * arbitrary binaries may rely upon it, so we must do the same.
 	 * For more details, see commit:
 	 *
-	 * 713c481519f19df9 ("[ARM] 3108/2: old ABI compat: statfs64 and
-	 * fstatfs64")
+	 * commit 713c481519f19df9 ("[ARM] 3108/2: old ABI compat: statfs64
+	 * and fstatfs64")
 	 */
 	if (sz == 88)
 		sz = 84;
-- 
1.8.3.1

