Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeBQLpq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:45:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41383 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeBQLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:45:43 -0500
Date: Sat, 17 Feb 2018 03:35:29 -0800
From: tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-1350fb7d1b484afc1556579fb27400d036683453@git.kernel.org>
Cc: tmricht@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
        tglx@linutronix.de, mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com, mingo@kernel.org,
        namhyung@kernel.org, hpa@zytor.com
Reply-To: jolsa@redhat.com, ravi.bangoria@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au, tglx@linutronix.de,
        tmricht@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
        hpa@zytor.com, namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com
In-Reply-To: <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
References: <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools include powerpc: Grab a copy of
 arch/powerpc/include/uapi/asm/unistd.h
Git-Commit-ID: 1350fb7d1b484afc1556579fb27400d036683453
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

Commit-ID:  1350fb7d1b484afc1556579fb27400d036683453
Gitweb:     https://git.kernel.org/tip/1350fb7d1b484afc1556579fb27400d036683453
Author:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
AuthorDate: Mon, 29 Jan 2018 14:04:15 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:47 -0300

tools include powerpc: Grab a copy of arch/powerpc/include/uapi/asm/unistd.h

Will be used for generating the syscall id/string translation table.

Committer notes:

Update it already to catch with these csets applied since Ravi first
submitted this patch:

  3350eb2ea127 powerpc: sys_pkey_mprotect() system call
  9499ec1b5e82 powerpc: sys_pkey_alloc() and sys_pkey_free() system calls

So now 'perf trace' on ppc now knows about the pkey_ syscals.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {arch => tools/arch}/powerpc/include/uapi/asm/unistd.h | 0
 tools/perf/check-headers.sh                            | 1 +
 2 files changed, 1 insertion(+)

diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
similarity index 100%
copy from arch/powerpc/include/uapi/asm/unistd.h
copy to tools/arch/powerpc/include/uapi/asm/unistd.h
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 790ec25..bf206ff 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -42,6 +42,7 @@ arch/parisc/include/uapi/asm/errno.h
 arch/powerpc/include/uapi/asm/errno.h
 arch/sparc/include/uapi/asm/errno.h
 arch/x86/include/uapi/asm/errno.h
+arch/powerpc/include/uapi/asm/unistd.h
 include/asm-generic/bitops/arch_hweight.h
 include/asm-generic/bitops/const_hweight.h
 include/asm-generic/bitops/__fls.h
