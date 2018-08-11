Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EBEC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 07:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC51D223E6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 07:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC51D223E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeHKJoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 05:44:25 -0400
Received: from nautica.notk.org ([91.121.71.147]:53973 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbeHKJoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 05:44:25 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id EA312C009; Sat, 11 Aug 2018 09:11:10 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        "Ronald G. Minnich" <rminnich@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: [PATCH] 9p: Remove Ron Minnich from MAINTAINERS
Date:   Sat, 11 Aug 2018 09:10:53 +0200
Message-Id: <1533971453-24314-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1533869305-29325-1-git-send-email-asmadeus@codewreck.org>
References: <1533869305-29325-1-git-send-email-asmadeus@codewreck.org>
To:     unlisted-recipients:; (no To-header on input)
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
---
Thanks for agreeing Ron.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

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

