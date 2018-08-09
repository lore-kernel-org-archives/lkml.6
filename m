Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E1EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72521EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A72521EB3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeHIQ5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:57:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43526 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730453AbeHIQ5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:57:46 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 336A3D9DB91F7;
        Thu,  9 Aug 2018 22:32:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Thu, 9 Aug 2018 22:32:25 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <will.deacon@arm.com>, <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] arm64:guest: remove some extra semicolon in kvm_target_cpu
Date:   Thu, 9 Aug 2018 22:20:41 +0800
Message-ID: <1533824441-35661-3-git-send-email-zhongjiang@huawei.com>
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

There are some extra semicolon in kvm_target_cpu, remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm64/kvm/guest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 07256b0..a74f84d 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -338,15 +338,15 @@ int __attribute_const__ kvm_target_cpu(void)
 			return KVM_ARM_TARGET_CORTEX_A53;
 		case ARM_CPU_PART_CORTEX_A57:
 			return KVM_ARM_TARGET_CORTEX_A57;
-		};
+		}
 		break;
 	case ARM_CPU_IMP_APM:
 		switch (part_number) {
 		case APM_CPU_PART_POTENZA:
 			return KVM_ARM_TARGET_XGENE_POTENZA;
-		};
+		}
 		break;
-	};
+	}
 
 	/* Return a default generic target */
 	return KVM_ARM_TARGET_GENERIC_V8;
-- 
1.7.12.4

