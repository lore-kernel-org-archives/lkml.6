Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED2BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F50120652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F50120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeJDWjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:39:13 -0400
Received: from mail78-59.sinamail.sina.com.cn ([219.142.78.59]:59147 "HELO
        mail78-59.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1727807AbeJDWjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:39:12 -0400
Received: from unknown (HELO localhost.localdomain)([139.204.57.91])
        by sina.com with ESMTP
        id 5BB63584000056A9; Thu, 4 Oct 2018 23:45:14 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 982833400383
From:   Peng Hao <penghao122@sina.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  kvm/x86 : fix some typo
Date:   Thu,  4 Oct 2018 11:45:00 -0400
Message-Id: <1538667900-25661-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d7e9bce..281e20e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4546,7 +4546,7 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 			 * SMAP:kernel-mode data accesses from user-mode
 			 * mappings should fault. A fault is considered
 			 * as a SMAP violation if all of the following
-			 * conditions are ture:
+			 * conditions are true:
 			 *   - X86_CR4_SMAP is set in CR4
 			 *   - A user page is accessed
 			 *   - The access is not a fetch
@@ -5891,7 +5891,7 @@ int kvm_mmu_module_init(void)
 }
 
 /*
- * Caculate mmu pages needed for kvm.
+ * Calculate mmu pages needed for kvm.
  */
 unsigned int kvm_mmu_calculate_mmu_pages(struct kvm *kvm)
 {
-- 
1.8.3.1


