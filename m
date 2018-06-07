Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id x3wjLL7rGFs8bAAAmS7hNA
	; Thu, 07 Jun 2018 08:26:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C75B7608BF; Thu,  7 Jun 2018 08:26:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 368C56063F;
	Thu,  7 Jun 2018 08:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 368C56063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932760AbeFGI0d (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:26:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932741AbeFGI0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:26:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578Q9Ck2128131
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:26:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578Q94f2128126;
        Thu, 7 Jun 2018 01:26:09 -0700
Date: Thu, 7 Jun 2018 01:26:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-ac56aa4549cdfd9c56387b35e99e3c868cfc7bd0@git.kernel.org>
Cc: ak@linux.intel.com, tglx@linutronix.de, yao.jin@intel.com,
        mingo@kernel.org, jolsa@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        yao.jin@linux.intel.com, kan.liang@linux.intel.com,
        acme@redhat.com, alexander.shishkin@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, yao.jin@linux.intel.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
          ak@linux.intel.com, yao.jin@intel.com, tglx@linutronix.de,
          mingo@kernel.org, jolsa@kernel.org
In-Reply-To: <1527843663-32288-4-git-send-email-yao.jin@linux.intel.com>
References: <1527843663-32288-4-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Add dict fields introduction
 to Documentation
Git-Commit-ID: ac56aa4549cdfd9c56387b35e99e3c868cfc7bd0
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

Commit-ID:  ac56aa4549cdfd9c56387b35e99e3c868cfc7bd0
Gitweb:     https://git.kernel.org/tip/ac56aa4549cdfd9c56387b35e99e3c868cfc7bd0
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 1 Jun 2018 17:01:03 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 15:40:10 -0300

perf script python: Add dict fields introduction to Documentation

Add a brief introduction about fields to perf-script-python.txt.

It should help python script developers in easily finding what fields
are supported.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1527843663-32288-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script-python.txt | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 51ec2d20068a..0fb9eda3cbca 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -610,6 +610,32 @@ Various utility functions for use with perf script:
   nsecs_str(nsecs) - returns printable string in the form secs.nsecs
   avg(total, n) - returns average given a sum and a total number of values
 
+SUPPORTED FIELDS
+----------------
+
+Currently supported fields:
+
+ev_name, comm, pid, tid, cpu, ip, time, period, phys_addr, addr,
+symbol, dso, time_enabled, time_running, values, callchain,
+brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
+weight, transaction, raw_buf, attr.
+
+Some fields have sub items:
+
+brstack:
+    from, to, from_dsoname, to_dsoname, mispred,
+    predicted, in_tx, abort, cycles.
+
+brstacksym:
+    items: from, to, pred, in_tx, abort (converted string)
+
+For example,
+We can use this code to print brstack "from", "to", "cycles".
+
+if 'brstack' in dict:
+	for entry in dict['brstack']:
+		print "from %s, to %s, cycles %s" % (entry["from"], entry["to"], entry["cycles"])
+
 SEE ALSO
 --------
 linkperf:perf-script[1]
