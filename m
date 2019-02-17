Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F63BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB1F218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfBQWwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:52:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41950 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfBQWwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:52:13 -0500
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gvVIA-0000cN-8D; Sun, 17 Feb 2019 22:52:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/test_rhashtable: fix spelling mistake "existant" -> "existent"
Date:   Sun, 17 Feb 2019 22:52:09 +0000
Message-Id: <20190217225209.17536-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in warning macro messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/test_rhashtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index e52f8cafe227..2c0c53a99734 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -395,7 +395,7 @@ static int __init test_rhltable(unsigned int entries)
 			if (WARN(err, "cannot remove element at slot %d", i))
 				continue;
 		} else {
-			if (WARN(err != -ENOENT, "removed non-existant element %d, error %d not %d",
+			if (WARN(err != -ENOENT, "removed non-existent element %d, error %d not %d",
 			     i, err, -ENOENT))
 				continue;
 		}
@@ -440,7 +440,7 @@ static int __init test_rhltable(unsigned int entries)
 			if (WARN(err, "cannot remove element at slot %d", i))
 				continue;
 		} else {
-			if (WARN(err != -ENOENT, "removed non-existant element, error %d not %d",
+			if (WARN(err != -ENOENT, "removed non-existent element, error %d not %d",
 				 err, -ENOENT))
 			continue;
 		}
-- 
2.20.1

