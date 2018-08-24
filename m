Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 04:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E1C208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 04:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E1C208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeHXHgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 03:36:39 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:37522 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHXHgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 03:36:39 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55b7f83a1925-d11e5; Fri, 24 Aug 2018 12:03:45 +0800 (CST)
X-RM-TRANSID: 2ee55b7f83a1925-d11e5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from bclinux72.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55b7f83a17a0-2eb86;
        Fri, 24 Aug 2018 12:03:45 +0800 (CST)
X-RM-TRANSID: 2ee55b7f83a17a0-2eb86
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: ubifs: remove unneeded semicolon
Date:   Fri, 24 Aug 2018 01:15:05 -0400
Message-Id: <1535087705-17637-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

delete redundant semicolon

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 fs/ubifs/sb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index bf17f58..d5c55e2 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -603,7 +603,7 @@ int ubifs_read_superblock(struct ubifs_info *c)
 		c->key_hash = key_test_hash;
 		c->key_hash_type = UBIFS_KEY_HASH_TEST;
 		break;
-	};
+	}
 
 	c->key_fmt = sup->key_fmt;
 
-- 
1.8.3.1



