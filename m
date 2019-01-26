Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A857C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBB2214C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfAZJzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:55:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZJzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:55:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0Q9swjP509852
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 01:54:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0Q9svnw509849;
        Sat, 26 Jan 2019 01:54:57 -0800
Date:   Sat, 26 Jan 2019 01:54:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4mavb7pgt2nw9lsew1xuez09@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com
Reply-To: jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf color: Add missing stdarg.g to color.h
Git-Commit-ID: b2251c327a09caa622047fe74363f650d31e4349
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

Commit-ID:  b2251c327a09caa622047fe74363f650d31e4349
Gitweb:     https://git.kernel.org/tip/b2251c327a09caa622047fe74363f650d31e4349
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 25 Jan 2019 15:11:08 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:08 +0100

perf color: Add missing stdarg.g to color.h

It was getting the va_list definition by luck.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4mavb7pgt2nw9lsew1xuez09@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/color.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index 22777b1812ee..01f7bed21c9b 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -3,6 +3,7 @@
 #define __PERF_COLOR_H
 
 #include <stdio.h>
+#include <stdarg.h>
 
 /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
 #define COLOR_MAXLEN 24
