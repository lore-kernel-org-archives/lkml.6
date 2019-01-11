Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5C2C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B02420836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbfAKQO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:14:27 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:57134 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfAKQO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:14:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 71A5F18577;
        Fri, 11 Jan 2019 17:14:23 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id UV7bZUXF5geG; Fri, 11 Jan 2019 17:14:22 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 6301F184FE;
        Fri, 11 Jan 2019 17:14:22 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 142731A066;
        Fri, 11 Jan 2019 17:14:22 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 082A61A065;
        Fri, 11 Jan 2019 17:14:22 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Fri, 11 Jan 2019 17:14:21 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id EFC68251;
        Fri, 11 Jan 2019 17:14:21 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id EB241801ED; Fri, 11 Jan 2019 17:14:21 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, dave.hansen@linux.intel.com,
        Vincent Whitchurch <rabinv@axis.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] Documentation/sysctl/vm.txt: Fix drop_caches bit number
Date:   Fri, 11 Jan 2019 17:14:10 +0100
Message-Id: <20190111161410.11831-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bits are usually numbered starting from zero, so 4 should be bit 2, not
bit 3.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 Documentation/sysctl/vm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 187ce4f599a2..6af24cdb25cc 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -237,7 +237,7 @@ used:
 	cat (1234): drop_caches: 3
 
 These are informational only.  They do not mean that anything is wrong
-with your system.  To disable them, echo 4 (bit 3) into drop_caches.
+with your system.  To disable them, echo 4 (bit 2) into drop_caches.
 
 ==============================================================
 
-- 
2.20.0

