Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F19C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320CD20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfBHREh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:04:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54276 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbfBHREe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:04:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 672FD80D;
        Fri,  8 Feb 2019 09:04:34 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57AE73F719;
        Fri,  8 Feb 2019 09:04:33 -0800 (PST)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Julien Grall <julien.grall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: Remove documentation about TIF_USEDFPU
Date:   Fri,  8 Feb 2019 17:04:25 +0000
Message-Id: <20190208170425.10891-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190208170425.10891-1-julien.grall@arm.com>
References: <20190208170425.10891-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIF_USEDFPU is not defined as thread flags for Arm64. So drop it from
the documentation.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index bbca68b54732..eb3ef73e07cf 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -79,7 +79,6 @@ void arch_release_task_struct(struct task_struct *tsk);
  *  TIF_SIGPENDING	- signal pending
  *  TIF_NEED_RESCHED	- rescheduling necessary
  *  TIF_NOTIFY_RESUME	- callback before returning to user
- *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
  */
 #define TIF_SIGPENDING		0
 #define TIF_NEED_RESCHED	1
-- 
2.11.0

