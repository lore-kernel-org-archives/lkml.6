Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A39C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507042082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507042082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeKZKbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:31:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55308 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKZKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:31:06 -0500
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gR3z7-0007V6-MZ; Sun, 25 Nov 2018 23:38:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: util: fix spelling mistake "Muliplier" -> "Multiplier"
Date:   Sun, 25 Nov 2018 23:38:41 +0000
Message-Id: <20181125233841.14942-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two instances of spelling mistakes of Multiplier, fix
these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/perf/util/intel-bts.c | 2 +-
 tools/perf/util/intel-pt.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 7b27d77306c2..075747492a52 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -851,7 +851,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 static const char * const intel_bts_info_fmts[] = {
 	[INTEL_BTS_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
 	[INTEL_BTS_TIME_SHIFT]		= "  Time Shift         %"PRIu64"\n",
-	[INTEL_BTS_TIME_MULT]		= "  Time Muliplier     %"PRIu64"\n",
+	[INTEL_BTS_TIME_MULT]		= "  Time Multiplier    %"PRIu64"\n",
 	[INTEL_BTS_TIME_ZERO]		= "  Time Zero          %"PRIu64"\n",
 	[INTEL_BTS_CAP_USER_TIME_ZERO]	= "  Cap Time Zero      %"PRId64"\n",
 	[INTEL_BTS_SNAPSHOT_MODE]	= "  Snapshot mode      %"PRId64"\n",
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 149ff361ca78..38fb12e11569 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2376,7 +2376,7 @@ static int intel_pt_perf_config(const char *var, const char *value, void *data)
 static const char * const intel_pt_info_fmts[] = {
 	[INTEL_PT_PMU_TYPE]		= "  PMU Type            %"PRId64"\n",
 	[INTEL_PT_TIME_SHIFT]		= "  Time Shift          %"PRIu64"\n",
-	[INTEL_PT_TIME_MULT]		= "  Time Muliplier      %"PRIu64"\n",
+	[INTEL_PT_TIME_MULT]		= "  Time Multiplier     %"PRIu64"\n",
 	[INTEL_PT_TIME_ZERO]		= "  Time Zero           %"PRIu64"\n",
 	[INTEL_PT_CAP_USER_TIME_ZERO]	= "  Cap Time Zero       %"PRId64"\n",
 	[INTEL_PT_TSC_BIT]		= "  TSC bit             %#"PRIx64"\n",
-- 
2.19.1

