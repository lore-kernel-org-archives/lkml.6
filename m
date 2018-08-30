Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E266320835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E266320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeH3TRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:17:17 -0400
Received: from bran.ispras.ru ([83.149.199.196]:19872 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727036AbeH3TRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:17:17 -0400
Received: from ubuntu.intra.ispras.ru (ultra.intra.ispras.ru [10.10.2.144])
        by smtp.ispras.ru (Postfix) with ESMTP id 947D8203CD;
        Thu, 30 Aug 2018 18:14:38 +0300 (MSK)
From:   Pavel Zemlyanoy <zemlyanoy@ispras.ru>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Cc:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH 3/6] staging: erofs: formatting spaces around '-'
Date:   Thu, 30 Aug 2018 18:13:59 +0300
Message-Id: <1535642042-5336-3-git-send-email-zemlyanoy@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change the logic, it only
corrects the formatting and checkpatch checks by
adding spaces around '-'.

The patch fixes 4 checks of type:
"Check: spaces preferred around that '-'".

Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>
---
 drivers/staging/erofs/unzip_vle_lz4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index 54da72a..bf1f51c 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -65,13 +65,13 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 
 		if (i) {
 			if (!src)
-				src = mirrored[i-1] ?
-					percpu_data + (i-1) * PAGE_SIZE :
-					kmap_atomic(compressed_pages[i-1]);
+				src = mirrored[i - 1] ?
+					percpu_data + (i - 1) * PAGE_SIZE :
+					kmap_atomic(compressed_pages[i - 1]);
 
 			memcpy(dst, src + righthalf, pageofs);
 
-			if (!mirrored[i-1])
+			if (!mirrored[i - 1])
 				kunmap_atomic(src);
 
 			if (unlikely(i >= clusterpages)) {
-- 
2.7.4

