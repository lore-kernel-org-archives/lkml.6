Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC12BC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E40721E25
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E40721E25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbeHIQ5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:57:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45279 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731751AbeHIQ5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:57:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE76AFD5BDD1;
        Thu,  9 Aug 2018 22:32:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Thu, 9 Aug 2018 22:32:24 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <will.deacon@arm.com>, <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64/kprobes: remove an extra semicolon in arch_prepare_kprobe
Date:   Thu, 9 Aug 2018 22:20:40 +0800
Message-ID: <1533824441-35661-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1533824441-35661-1-git-send-email-zhongjiang@huawei.com>
References: <1533824441-35661-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extra semicolon in arch_prepare_kprobe, remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm64/kernel/probes/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index e78c3ef..9b65132 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -107,7 +107,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		if (!p->ainsn.api.insn)
 			return -ENOMEM;
 		break;
-	};
+	}
 
 	/* prepare the instruction */
 	if (p->ainsn.api.insn)
-- 
1.7.12.4

