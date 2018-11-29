Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149D4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C0B2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C0B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeK2Vgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:36:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeK2Vgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:36:35 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gSJbZ-0005wG-KW; Thu, 29 Nov 2018 10:31:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: fix spelling mistake "sythesizing" -> "synthesizing"
Date:   Thu, 29 Nov 2018 10:31:33 +0000
Message-Id: <20181129103133.17353-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in TEST_ASSERT_VAL messages, fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/perf/tests/mmap-thread-lookup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index b1af2499a3c9..e8498d3e0176 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -224,11 +224,11 @@ static int mmap_events(synth_cb synth)
 int test__mmap_thread_lookup(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	/* perf_event__synthesize_threads synthesize */
-	TEST_ASSERT_VAL("failed with sythesizing all",
+	TEST_ASSERT_VAL("failed with synthesizing all",
 			!mmap_events(synth_all));
 
 	/* perf_event__synthesize_thread_map synthesize */
-	TEST_ASSERT_VAL("failed with sythesizing process",
+	TEST_ASSERT_VAL("failed with synthesizing process",
 			!mmap_events(synth_process));
 
 	return 0;
-- 
2.19.1

