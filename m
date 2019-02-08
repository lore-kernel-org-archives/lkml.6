Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53368C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8E72146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfBHRDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:03:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54190 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfBHRD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:03:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 034961596;
        Fri,  8 Feb 2019 09:03:26 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3181B3F719;
        Fri,  8 Feb 2019 09:03:25 -0800 (PST)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Julien Grall <julien.grall@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] arm: Remove documentation about TIF_USEDFPU
Date:   Fri,  8 Feb 2019 17:03:14 +0000
Message-Id: <20190208170315.10762-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190208170315.10762-1-julien.grall@arm.com>
References: <20190208170315.10762-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIF_USEDFPU is not defined as thread flags for Arm. So drop it from
the documentation.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 286eb61c632b..779927f0c3c1 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -132,7 +132,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 
 /*
  * thread information flags:
- *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
  *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
  */
 #define TIF_SIGPENDING		0	/* signal pending */
-- 
2.11.0

