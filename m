Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A47C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279C221788
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279C221788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeHQJNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:13:00 -0400
Received: from nautica.notk.org ([91.121.71.147]:49686 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeHQJM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:12:59 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 11ED7C009; Fri, 17 Aug 2018 08:10:54 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        "Ronald G. Minnich" <rminnich@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: [PATCH v2] 9p: Remove Ron Minnich from MAINTAINERS
Date:   Fri, 17 Aug 2018 08:10:44 +0200
Message-Id: <1534486244-1055-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1534394486-11649-1-git-send-email-asmadeus@codewreck.org>
References: <1534394486-11649-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

Ron Minnich has left Sandia in 2011, and has not been involved in any
9p commit in the recent years.

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Ron Minnich <rminnich@sandia.gov>
Cc: Ronald G. Minnich <rminnich@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
To: Andrew Morton <akpm@linux-foundation.org>
---
v2: added CREDITS entry

 CREDITS     | 5 +++++
 MAINTAINERS | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 989cda91c427..5befd2d714d0 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2571,6 +2571,11 @@ S: Helstorfer Str. 7
 S: D-30625 Hannover
 S: Germany
 
+N: Ron Minnich
+E: rminnich@sandia.gov
+E: rminnich@gmail.com
+D: 9p filesystem development
+
 N: Corey Minyard
 E: minyard@wf-rch.cirr.com
 E: minyard@mvista.com
diff --git a/MAINTAINERS b/MAINTAINERS
index 15116e6dff3a..09c2a6c0fb0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -199,7 +199,6 @@ F:	drivers/net/ethernet/8390/
 
 9P FILE SYSTEM
 M:	Eric Van Hensbergen <ericvh@gmail.com>
-M:	Ron Minnich <rminnich@sandia.gov>
 M:	Latchesar Ionkov <lucho@ionkov.net>
 M:	Dominique Martinet <asmadeus@codewreck.org>
 L:	v9fs-developer@lists.sourceforge.net
-- 
2.17.1

