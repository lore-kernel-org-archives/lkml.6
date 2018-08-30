Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EA3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBF2205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBF2205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeH3TRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:17:21 -0400
Received: from bran.ispras.ru ([83.149.199.196]:19905 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbeH3TRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:17:20 -0400
Received: from ubuntu.intra.ispras.ru (ultra.intra.ispras.ru [10.10.2.144])
        by smtp.ispras.ru (Postfix) with ESMTP id 4D713203B2;
        Thu, 30 Aug 2018 18:14:40 +0300 (MSK)
From:   Pavel Zemlyanoy <zemlyanoy@ispras.ru>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Cc:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH 5/6] staging: erofs: formatting alignment parenthesis
Date:   Thu, 30 Aug 2018 18:14:01 +0300
Message-Id: <1535642042-5336-5-git-send-email-zemlyanoy@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change the logic, it only
corrects the formatting and checkpatch check by
alignment should match open parenthesis.

The patch fixes 2 check of type:
"Check: Alignment should match open parenthesis".

Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>
---
 drivers/staging/erofs/unzip_vle_lz4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index 7389500..f285a50 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -126,7 +126,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	vout = erofs_pcpubuf[smp_processor_id()].data;
 
 	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
-		clusterpages * PAGE_SIZE, outlen);
+				clusterpages * PAGE_SIZE, outlen);
 
 	if (ret >= 0) {
 		outlen = ret;
@@ -191,7 +191,7 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 	}
 
 	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
-		clusterpages * PAGE_SIZE, llen);
+				clusterpages * PAGE_SIZE, llen);
 	if (ret > 0)
 		ret = 0;
 
-- 
2.7.4

