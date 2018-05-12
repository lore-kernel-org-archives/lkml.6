Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeELVK6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 17:10:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeELVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 17:10:56 -0400
Date: Sat, 12 May 2018 14:10:49 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-1d200c078d0e3e49e2995b9d25fef8926d491f4f@git.kernel.org>
Cc: hpa@zytor.com, suravee.suthikulpanit@amd.com, tglx@linutronix.de,
        mingo@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1524864877-111962-4-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524864877-111962-4-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU: Rename intel_cacheinfo.c to cacheinfo.c
Git-Commit-ID: 1d200c078d0e3e49e2995b9d25fef8926d491f4f
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

Commit-ID:  1d200c078d0e3e49e2995b9d25fef8926d491f4f
Gitweb:     https://git.kernel.org/tip/1d200c078d0e3e49e2995b9d25fef8926d491f4f
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 27 Apr 2018 16:34:36 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 6 May 2018 12:49:15 +0200

x86/CPU: Rename intel_cacheinfo.c to cacheinfo.c

Since this file contains general cache-related information for x86,
rename the file to a more generic name.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1524864877-111962-4-git-send-email-suravee.suthikulpanit@amd.com

---
 arch/x86/kernel/cpu/Makefile                           | 2 +-
 arch/x86/kernel/cpu/{intel_cacheinfo.c => cacheinfo.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index a66229f51b12..7a40196967cb 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -17,7 +17,7 @@ KCOV_INSTRUMENT_perf_event.o := n
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_common.o		:= $(nostackp)
 
-obj-y			:= intel_cacheinfo.o scattered.o topology.o
+obj-y			:= cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
diff --git a/arch/x86/kernel/cpu/intel_cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
similarity index 100%
rename from arch/x86/kernel/cpu/intel_cacheinfo.c
rename to arch/x86/kernel/cpu/cacheinfo.c
