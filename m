Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeDUHwl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:52:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58425 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeDUHwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:52:39 -0400
Date: Sat, 21 Apr 2018 00:51:27 -0700
From: tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-6a02f06edea5a5910c787fd6c49b0552e8080e5d@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
        ak@linux.intel.com
Reply-To: ak@linux.intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180406203812.3087-3-andi@firstfloor.org>
References: <20180406203812.3087-3-andi@firstfloor.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists browser: Clarify top/report browser
 help
Git-Commit-ID: 6a02f06edea5a5910c787fd6c49b0552e8080e5d
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

Commit-ID:  6a02f06edea5a5910c787fd6c49b0552e8080e5d
Gitweb:     https://git.kernel.org/tip/6a02f06edea5a5910c787fd6c49b0552e8080e5d
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:38:10 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 18 Apr 2018 15:35:49 -0300

perf hists browser: Clarify top/report browser help

Clarify in the browser help that ESC in tui mode may go back to the
previous screen instead of just exiting (was not clear to me)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180406203812.3087-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 0eec06c105c6..e5f247247daa 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2714,7 +2714,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 	"h/?/F1        Show this window\n"				\
 	"UP/DOWN/PGUP\n"						\
 	"PGDN/SPACE    Navigate\n"					\
-	"q/ESC/CTRL+C  Exit browser\n\n"				\
+	"q/ESC/CTRL+C  Exit browser or go back to previous screen\n\n"	\
 	"For multiple event sessions:\n\n"				\
 	"TAB/UNTAB     Switch events\n\n"				\
 	"For symbolic views (--sort has sym):\n\n"			\
