Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BABC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9D2206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfABJhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:37:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37359 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfABJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:37:08 -0500
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gecxT-0005tx-Mb; Wed, 02 Jan 2019 09:37:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] cgroup: fix spelling mistake "paramter" -> "parameter"
Date:   Wed,  2 Jan 2019 09:37:03 +0000
Message-Id: <20190102093703.32506-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the message in a cg_invalf call, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index e20a08ce9655..e72699dec620 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1019,7 +1019,7 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_name:
 		/* blocked by boot param? */
 		if (cgroup_no_v1_named)
-			return cg_invalf(fc, "cgroup1: Blocked by boot paramter");
+			return cg_invalf(fc, "cgroup1: Blocked by boot parameter");
 		/* Can't specify an empty name */
 		if (!param->size)
 			return cg_invalf(fc, "cgroup1: Empty name");
-- 
2.19.1

