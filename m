Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89ECC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94526217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfAZKAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:00:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:00:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QA0dWT510804
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:00:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QA0d2o510800;
        Sat, 26 Jan 2019 02:00:39 -0800
Date:   Sat, 26 Jan 2019 02:00:39 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-bodhwdvcds9ahk26dy4w8m71@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
        hpa@zytor.com, jolsa@kernel.org, acme@redhat.com
Reply-To: hpa@zytor.com, mingo@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, acme@redhat.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf callchain: No need to include perf.h
Git-Commit-ID: 95420d338e2d802ea0dce4d770d3292beb587f71
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

Commit-ID:  95420d338e2d802ea0dce4d770d3292beb587f71
Gitweb:     https://git.kernel.org/tip/95420d338e2d802ea0dce4d770d3292beb587f71
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 22 Jan 2019 11:32:41 -0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:09 +0100

perf callchain: No need to include perf.h

So ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bodhwdvcds9ahk26dy4w8m71@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 99d38ac019b8..8afe1622edf3 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -2,7 +2,6 @@
 #ifndef __PERF_CALLCHAIN_H
 #define __PERF_CALLCHAIN_H
 
-#include "../perf.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include "event.h"
