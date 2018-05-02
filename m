Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750966AbeEBHyE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:54:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42807 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBHyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:54:03 -0400
X-Google-Smtp-Source: AB8JxZrFlZriRq75iPXJxjIRjsha3XcX4FClCzU4+142TBCQ8BV3phkMBM/1jS/jXgWeVQ82E4J/bw==
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
To: ldufour@linux.vnet.ibm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: [PATCH 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Date: Wed,  2 May 2018 15:53:21 +0800
Message-Id: <1525247602-1565-1-git-send-email-opensource.ganesh@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
enables Speculative Page Fault handler.

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
---
This patch is on top of Laurent's v10 spf
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..cd583a9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -144,6 +144,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT if SMP
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-- 
1.9.1
