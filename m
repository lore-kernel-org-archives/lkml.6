Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DADC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD82086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBD82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeH2MAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:00:01 -0400
Received: from mail1.windriver.com ([147.11.146.13]:62550 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeH2MAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:00:01 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w7T84GKh012896
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 29 Aug 2018 01:04:16 -0700 (PDT)
Received: from pek-lyang0-d1.corp.ad.wrs.com (128.224.162.194) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 Aug 2018 01:04:03 -0700
From:   Lei Yang <Lei.Yang@windriver.com>
To:     <lei.yang@windriver.com>, <shuahkh@osg.samsung.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH]] zram: kselftests: correct README
Date:   Wed, 29 Aug 2018 16:06:12 +0800
Message-ID: <1535529972-9038-1-git-send-email-Lei.Yang@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ZRAM=y should be CONFIG_ZRAM=m
it obviously uses zram kernel module in the testing

Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
---
 tools/testing/selftests/zram/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/zram/README b/tools/testing/selftests/zram/README
index 7972cc5..501223a 100644
--- a/tools/testing/selftests/zram/README
+++ b/tools/testing/selftests/zram/README
@@ -12,7 +12,7 @@ Statistics for individual zram devices are exported through sysfs nodes at
 /sys/block/zram<id>/
 
 Kconfig required:
-CONFIG_ZRAM=y
+CONFIG_ZRAM=m
 CONFIG_CRYPTO_LZ4=y
 CONFIG_ZPOOL=y
 CONFIG_ZSMALLOC=y
-- 
1.9.1

