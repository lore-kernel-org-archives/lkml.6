Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C6C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DEE21919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBIMjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:39:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:39:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CdMde2629243
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:39:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CdM2i2629240;
        Sat, 9 Feb 2019 04:39:22 -0800
Date:   Sat, 9 Feb 2019 04:39:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-c3h8oyav16iu5ivput8n4wt6@git.kernel.org>
Cc:     hpa@zytor.com, namhyung@kernel.org, adrian.hunter@intel.com,
        hemant@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        acme@redhat.com
Reply-To: tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, namhyung@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, hemant@linux.vnet.ibm.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf powerpc kvm-stat: Add missing evlist.h header
Git-Commit-ID: 5afbb37c68ab1ca9746e5c9ee2f61e9cae67da42
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

Commit-ID:  5afbb37c68ab1ca9746e5c9ee2f61e9cae67da42
Gitweb:     https://git.kernel.org/tip/5afbb37c68ab1ca9746e5c9ee2f61e9cae67da42
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 5 Feb 2019 19:04:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

perf powerpc kvm-stat: Add missing evlist.h header

This header was being obtained indirectly, by sheer luck, add it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c3h8oyav16iu5ivput8n4wt6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 86e64c47d8ea..f9db341c47b6 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -4,6 +4,7 @@
 #include "util/parse-events.h"
 #include "util/debug.h"
 #include "util/evsel.h"
+#include "util/evlist.h"
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
