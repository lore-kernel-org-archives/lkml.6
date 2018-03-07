Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934181AbeCGPwE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:52:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934060AbeCGPv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:51:57 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 18/19] perf build: Add llvm/clang make targets to FILES
Date: Wed,  7 Mar 2018 16:50:19 +0100
Message-Id: <20180307155020.32613-19-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So they can follow the OUTPUT variable setup as the
rest of the features.

Link: http://lkml.kernel.org/n/tip-9i5z6mkc9i4ivmtc8b078nqu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/build/feature/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0a490cb15149..f8ad640ffe5d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -54,7 +54,10 @@ FILES=                                          \
          test-jvmti.bin				\
          test-sched_getcpu.bin			\
          test-setns.bin				\
-         test-libopencsd.bin
+         test-libopencsd.bin			\
+         test-clang.bin				\
+         test-llvm.bin				\
+         test-llvm-version.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
-- 
2.13.6
