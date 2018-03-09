Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeCII4k (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:56:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeCII4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:56:38 -0500
Date: Fri, 9 Mar 2018 00:56:18 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-36f9dc33b9128b85e096f6fff83e05d49448b28e@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, jolsa@kernel.org, dsahern@gmail.com,
        namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, peterz@infradead.org
In-Reply-To: <20180307155020.32613-19-jolsa@kernel.org>
References: <20180307155020.32613-19-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf build: Add llvm/clang make targets to FILES
Git-Commit-ID: 36f9dc33b9128b85e096f6fff83e05d49448b28e
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

Commit-ID:  36f9dc33b9128b85e096f6fff83e05d49448b28e
Gitweb:     https://git.kernel.org/tip/36f9dc33b9128b85e096f6fff83e05d49448b28e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:19 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:49 -0300

perf build: Add llvm/clang make targets to FILES

So they can follow the OUTPUT variable setup as the rest of the
features.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
 
