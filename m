Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbeDZKBS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:01:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53575 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbeDZKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:01:16 -0400
Date: Thu, 26 Apr 2018 03:00:52 -0700
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-7d878817db22f64c2b2c241335ec03e4c3fd5476@git.kernel.org>
Cc: douly.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, douly.fnst@cn.fujitsu.com
In-Reply-To: <20180426060832.27312-1-douly.fnst@cn.fujitsu.com>
References: <20180426060832.27312-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vector: Remove the unused macro FPU_IRQ
Git-Commit-ID: 7d878817db22f64c2b2c241335ec03e4c3fd5476
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7d878817db22f64c2b2c241335ec03e4c3fd5476
Gitweb:     https://git.kernel.org/tip/7d878817db22f64c2b2c241335ec03e4c3fd5476
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Thu, 26 Apr 2018 14:08:32 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 11:57:57 +0200

x86/vector: Remove the unused macro FPU_IRQ

The macro FPU_IRQ has never been used since v3.10, So remove it.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180426060832.27312-1-douly.fnst@cn.fujitsu.com

---
 arch/x86/include/asm/irq_vectors.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 57003074bd7a..548d90bbf919 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -114,8 +114,6 @@
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
 
-#define FPU_IRQ				  13
-
 /*
  * Size the maximum number of interrupts.
  *
