Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17EEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FBB208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FBB208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeGLOJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:09:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbeGLOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:09:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CDwq1o3934315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 06:58:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CDwqNX3934312;
        Thu, 12 Jul 2018 06:58:52 -0700
Date:   Thu, 12 Jul 2018 06:58:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jeremy Cline <tipbot@zytor.com>
Message-ID: <tip-2ab89262ff8895b8476b97345507c676fe3081fa@git.kernel.org>
Cc:     jolsa@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
        herton@redhat.com, jeremy@jcline.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          acme@redhat.com, herton@redhat.com, jeremy@jcline.org,
          mingo@kernel.org, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          jolsa@redhat.com
In-Reply-To: <0100016341a72d26-75729663-fe55-4309-8c9b-302e065ed2f1-000000@email.amazonses.com>
References: <0100016341a72d26-75729663-fe55-4309-8c9b-302e065ed2f1-000000@email.amazonses.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: Add Python 3 support to
 SchedGui.py
Git-Commit-ID: 2ab89262ff8895b8476b97345507c676fe3081fa
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

Commit-ID:  2ab89262ff8895b8476b97345507c676fe3081fa
Gitweb:     https://git.kernel.org/tip/2ab89262ff8895b8476b97345507c676fe3081fa
Author:     Jeremy Cline <jeremy@jcline.org>
AuthorDate: Tue, 8 May 2018 21:27:45 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 10:01:50 -0300

perf scripts python: Add Python 3 support to SchedGui.py

Fix a single syntax error in SchedGui.py to support both Python 2 and
Python 3. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a72d26-75729663-fe55-4309-8c9b-302e065ed2f1-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
index fdd92f699055..cac7b2542ee8 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
@@ -11,7 +11,7 @@
 try:
 	import wx
 except ImportError:
-	raise ImportError, "You need to install the wxpython lib for this script"
+	raise ImportError("You need to install the wxpython lib for this script")
 
 
 class RootFrame(wx.Frame):
