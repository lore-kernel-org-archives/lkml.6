Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeDFUiS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:38:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:46004 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbeDFUiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:38:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="214550726"
From: Andi Kleen <andi@firstfloor.org>
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/4] perf, tools: Clarify browser help
Date: Fri,  6 Apr 2018 13:38:10 -0700
Message-Id: <20180406203812.3087-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180406203812.3087-1-andi@firstfloor.org>
References: <20180406203812.3087-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Clarify in the browser help that ESC in tui mode may go back to the
previous screen instead of just exiting (was not clear to me)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8b4e82548f8e..0abbc0048a8e 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2788,7 +2788,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 	"h/?/F1        Show this window\n"				\
 	"UP/DOWN/PGUP\n"						\
 	"PGDN/SPACE    Navigate\n"					\
-	"q/ESC/CTRL+C  Exit browser\n\n"				\
+	"q/ESC/CTRL+C  Exit browser or go back to previous screen\n\n"	\
 	"For multiple event sessions:\n\n"				\
 	"TAB/UNTAB     Switch events\n\n"				\
 	"For symbolic views (--sort has sym):\n\n"			\
-- 
2.14.3
