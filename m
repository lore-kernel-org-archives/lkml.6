Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6403BC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A42521E17
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A42521E17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHJFQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:16:29 -0400
Received: from nautica.notk.org ([91.121.71.147]:37909 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeHJFQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:16:29 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 0C96AC009; Fri, 10 Aug 2018 04:48:41 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Ron Minnich <rminnich@sandia.gov>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH] 9p: Add Dominique Martinet to MAINTAINERS
Date:   Fri, 10 Aug 2018 04:48:24 +0200
Message-Id: <1533869305-29325-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Ron Minnich <rminnich@sandia.gov>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

I've had an off-list Ack from Lucho and Eric about adding myself, and
got reminded I should probably do it sooner than later by Andrew.

Could (a subset of) you three please confirm on the list?

(As usual, I was a bit hesitant on what email to use, but I really would
not be reactive on my work email so it probably is better that way)


FWIW, I did not get any answer from Ron when I tried reaching out to
him, but I finally found why: he left sandia 7 years ago so that mail
is likely a black hole.
I've sent him a mail on another address now asking him if he is ok to
be removed, and will probably submit another patch doing that within
the next few days.


 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cebd5bba8a8..15116e6dff3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -201,10 +201,12 @@ F:	drivers/net/ethernet/8390/
 M:	Eric Van Hensbergen <ericvh@gmail.com>
 M:	Ron Minnich <rminnich@sandia.gov>
 M:	Latchesar Ionkov <lucho@ionkov.net>
+M:	Dominique Martinet <asmadeus@codewreck.org>
 L:	v9fs-developer@lists.sourceforge.net
 W:	http://swik.net/v9fs
 Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
+T:	git git://github.com/martinetd/linux.git
 S:	Maintained
 F:	Documentation/filesystems/9p.txt
 F:	fs/9p/
-- 
2.17.1

