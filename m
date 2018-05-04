Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEDG6X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:58:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45742 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEDG6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:58:22 -0400
X-Google-Smtp-Source: AB8JxZpO2epBpCPm5Sms8I4xihdcINUL5tT95NpEEopDSLMwKY2HNVbhgX70egI4c/IEwRUc+q1u4Q==
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
To: ldufour@linux.vnet.ibm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, cpandya@codeaurora.org,
        punit.agrawal@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: [PATCH v2 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Date: Fri,  4 May 2018 14:57:48 +0800
Message-Id: <1525417069-27401-1-git-send-email-opensource.ganesh@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
enables Speculative Page Fault handler.

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
---
v2: remove "if SMP"
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..b3ca29d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -144,6 +144,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-- 
1.9.1
