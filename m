Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935659AbeEJSOU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:14:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39827 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935403AbeEJSOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:14:15 -0400
Date: Thu, 10 May 2018 11:14:03 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1vo20y5z2drlujfpltjudwk8@git.kernel.org>
Cc: jolsa@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, dsahern@gmail.com,
        wangnan0@huawei.com, namhyung@kernel.org, mingo@kernel.org,
        fenghua.yu@intel.com, adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        acme@redhat.com, hpa@zytor.com, dsahern@gmail.com, namhyung@kernel.org,
        wangnan0@huawei.com, adrian.hunter@intel.com, mingo@kernel.org,
        fenghua.yu@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Sync x86 cpufeatures.h with the
 kernel sources
Git-Commit-ID: 605e71cd007b1897a4c5eda952acadd61b6a98f0
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

Commit-ID:  605e71cd007b1897a4c5eda952acadd61b6a98f0
Gitweb:     https://git.kernel.org/tip/605e71cd007b1897a4c5eda952acadd61b6a98f0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 7 May 2018 12:22:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 7 May 2018 15:23:45 -0300

tools headers: Sync x86 cpufeatures.h with the kernel sources

The 912413057395 ("x86/cpufeatures: Enumerate cldemote instruction")
doesn't requires changes in the tools, just copy it to silence this
warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1vo20y5z2drlujfpltjudwk8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index d554c11e01ff..578793e97431 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -320,6 +320,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
