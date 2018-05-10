Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757253AbeEJSNr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:13:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40055 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756741AbeEJSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:13:46 -0400
Date: Thu, 10 May 2018 11:13:00 -0700
From: tip-bot for Yisheng Xie <tipbot@zytor.com>
Message-ID: <tip-2abb80dad3afa9170ae19ca03bb7b4cd1ec06d62@git.kernel.org>
Cc: mingo@kernel.org, xieyisheng1@huawei.com, acme@redhat.com,
        peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, tglx@linutronix.de
Reply-To: acme@redhat.com, peterz@infradead.org, xieyisheng1@huawei.com,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1524644707-11030-1-git-send-email-xieyisheng1@huawei.com>
References: <1524644707-11030-1-git-send-email-xieyisheng1@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bench numa: Fix typo in options
Git-Commit-ID: 2abb80dad3afa9170ae19ca03bb7b4cd1ec06d62
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

Commit-ID:  2abb80dad3afa9170ae19ca03bb7b4cd1ec06d62
Gitweb:     https://git.kernel.org/tip/2abb80dad3afa9170ae19ca03bb7b4cd1ec06d62
Author:     Yisheng Xie <xieyisheng1@huawei.com>
AuthorDate: Wed, 25 Apr 2018 16:25:07 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 7 May 2018 12:17:56 -0300

perf bench numa: Fix typo in options

'R' means access the data via reads instead of writes, fix this typo.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1524644707-11030-1-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 944070e98a2c..63eb49082774 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -175,7 +175,7 @@ static const struct option options[] = {
 	OPT_UINTEGER('s', "nr_secs"	, &p0.nr_secs,		"max number of seconds to run (default: 5 secs)"),
 	OPT_UINTEGER('u', "usleep"	, &p0.sleep_usecs,	"usecs to sleep per loop iteration"),
 
-	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via writes (can be mixed with -W)"),
+	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via reads (can be mixed with -W)"),
 	OPT_BOOLEAN('W', "data_writes"	, &p0.data_writes,	"access the data via writes (can be mixed with -R)"),
 	OPT_BOOLEAN('B', "data_backwards", &p0.data_backwards,	"access the data backwards as well"),
 	OPT_BOOLEAN('Z', "data_zero_memset", &p0.data_zero_memset,"access the data via glibc bzero only"),
