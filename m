Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B42CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D8F20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfAVKQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:16:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfAVKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:16:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAF5eo2906863
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:15:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAF4hr2906860;
        Tue, 22 Jan 2019 02:15:04 -0800
Date:   Tue, 22 Jan 2019 02:15:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Brajeswar Ghosh <tipbot@zytor.com>
Message-ID: <tip-3eb03a5208a4eb46443e23e3fa9eb7e4c7ae4885@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@redhat.com, acme@redhat.com,
        jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com, brajeswar.linux@gmail.com,
        hpa@zytor.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, colin.king@canonical.com
Reply-To: jrdr.linux@gmail.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com,
          brajeswar.linux@gmail.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          mingo@kernel.org, jolsa@redhat.com, tglx@linutronix.de,
          namhyung@kernel.org, colin.king@canonical.com
In-Reply-To: <20190115135916.GA3629@hp-pavilion-15-notebook-pc-brajeswar>
References: <20190115135916.GA3629@hp-pavilion-15-notebook-pc-brajeswar>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Remove duplicate headers
Git-Commit-ID: 3eb03a5208a4eb46443e23e3fa9eb7e4c7ae4885
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3eb03a5208a4eb46443e23e3fa9eb7e4c7ae4885
Gitweb:     https://git.kernel.org/tip/3eb03a5208a4eb46443e23e3fa9eb7e4c7ae4885
Author:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
AuthorDate: Tue, 15 Jan 2019 19:29:16 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 15:15:57 -0300

perf tools: Remove duplicate headers

Remove duplicate headers which are included more than once in the same
file.

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Colin King <colin.king@canonical.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Link: http://lkml.kernel.org/r/20190115135916.GA3629@hp-pavilion-15-notebook-pc-brajeswar
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c     | 1 -
 tools/perf/tests/bp_account.c | 1 -
 tools/perf/util/dso.h         | 1 -
 tools/perf/util/zlib.c        | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc7f32b..e587808591e8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -83,7 +83,6 @@
 #include <unistd.h>
 #include <sys/time.h>
 #include <sys/resource.h>
-#include <sys/wait.h>
 
 #include "sane_ctype.h"
 
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index a20cbc445426..57fc544aedb0 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -15,7 +15,6 @@
 #include <sys/mman.h>
 #include <linux/compiler.h>
 #include <linux/hw_breakpoint.h>
-#include <sys/ioctl.h>
 
 #include "tests.h"
 #include "debug.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 8c8a7abe809d..af2eda29660f 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -8,7 +8,6 @@
 #include <sys/types.h>
 #include <stdbool.h>
 #include "rwsem.h"
-#include <linux/types.h>
 #include <linux/bitops.h>
 #include "map.h"
 #include "namespaces.h"
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 902ce6384f57..512ad7c09b13 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -6,7 +6,6 @@
 #include <sys/mman.h>
 #include <zlib.h>
 #include <linux/compiler.h>
-#include <unistd.h>
 
 #include "util/compress.h"
 #include "util/util.h"
