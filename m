Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D70C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D6C24141
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D6C24141
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934176AbeGCRFV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:05:21 -0400
Received: from anholt.net ([50.246.234.109]:41052 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934004AbeGCRFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:05:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 36B6210A18B9;
        Tue,  3 Jul 2018 10:05:18 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Z1tIAODACgoi; Tue,  3 Jul 2018 10:05:16 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7573610A1772;
        Tue,  3 Jul 2018 10:05:16 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 763D72FE463D; Tue,  3 Jul 2018 10:05:15 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4/4] drm/v3d: Fix a grammar nit in the scheduler docs.
Date:   Tue,  3 Jul 2018 10:05:15 -0700
Message-Id: <20180703170515.6298-4-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180703170515.6298-1-eric@anholt.net>
References: <20180703170515.6298-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 00667c733dca..a5501581d96b 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -14,8 +14,8 @@
  * to the HW only when it has completed the last one, instead of
  * filling up the CT[01]Q FIFOs with jobs.  Similarly, we use
  * v3d_job_dependency() to manage the dependency between bin and
- * render, instead of having the clients submit jobs with using the
- * HW's semaphores to interlock between them.
+ * render, instead of having the clients submit jobs using the HW's
+ * semaphores to interlock between them.
  */
 
 #include <linux/kthread.h>
-- 
2.18.0

