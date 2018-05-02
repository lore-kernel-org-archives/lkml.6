Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEBSGL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:06:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:06:08 -0400
Date: Wed, 2 May 2018 11:04:45 -0700
From: tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-246907611e3cac6b1be2af91539172c008f47278@git.kernel.org>
Cc: acme@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        colin.king@canonical.com
Reply-To: acme@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        colin.king@canonical.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180427193158.17932-1-colin.king@canonical.com>
References: <20180427193158.17932-1-colin.king@canonical.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix spelling mistake: "builid" ->
 "buildid"
Git-Commit-ID: 246907611e3cac6b1be2af91539172c008f47278
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

Commit-ID:  246907611e3cac6b1be2af91539172c008f47278
Gitweb:     https://git.kernel.org/tip/246907611e3cac6b1be2af91539172c008f47278
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Fri, 27 Apr 2018 20:31:58 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 30 Apr 2018 12:02:03 -0300

perf tools: Fix spelling mistake: "builid" -> "buildid"

Trivial fix to spelling mistake in error message text

Signed-off-by: Colin King <colin.king@canonical.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: http://lkml.kernel.org/r/20180427193158.17932-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/genelf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index c540d47583e7..aafbe54fd3fa 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -114,7 +114,7 @@ gen_build_id(struct buildid_note *note,
 
 	fd = open("/dev/urandom", O_RDONLY);
 	if (fd == -1)
-		err(1, "cannot access /dev/urandom for builid");
+		err(1, "cannot access /dev/urandom for buildid");
 
 	sret = read(fd, note->build_id, sz);
 
