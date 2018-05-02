Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeEBHyu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:54:50 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37307 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeEBHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:54:49 -0400
X-Google-Smtp-Source: AB8JxZqdydkLPwZ8BOYaWvtB3/NEClO35KMro3JaRXjAM90MAfCX/onaceNCFFYqYTUD2R2t/bkfCA==
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
To: ldufour@linux.vnet.ibm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: [PATCH 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Date: Wed,  2 May 2018 15:54:31 +0800
Message-Id: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
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
