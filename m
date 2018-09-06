Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD0FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961F620867
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961F620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeIFKTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:19:21 -0400
Received: from mail1.windriver.com ([147.11.146.13]:46418 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeIFKTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:19:21 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w865jYgZ016547
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 5 Sep 2018 22:45:34 -0700 (PDT)
Received: from pek-lyang0-d1.corp.ad.wrs.com (128.224.162.194) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Wed, 5 Sep 2018 22:45:22 -0700
From:   Lei Yang <Lei.Yang@windriver.com>
To:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <claudiozumbo@gmail.com>
Subject: [PATCH v2] cgroup: kselftests: add test_core to .gitignore
Date:   Thu, 6 Sep 2018 13:47:23 +0800
Message-ID: <1536212843-3774-1-git-send-email-Lei.Yang@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update .gitignore file.

Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
---
 tools/testing/selftests/cgroup/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index 95eb3a5..adacda5 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -1 +1,2 @@
 test_memcontrol
+test_core
-- 
1.9.1

