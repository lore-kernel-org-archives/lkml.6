Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeBET5u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:57:50 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42680 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeBET5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:57:32 -0500
X-Google-Smtp-Source: AH8x2277XX0rEWupTWQqyJJ9SFHRufrqUciHc5DyQhCWoeWYGjY9qUWTOuEAQGiwsgE/KpfBsSR95w==
From: Sangwon Hong <qpakzk@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, Sangwon Hong <qpakzk@gmail.com>
Subject: [PATCH 1/2] perf trace: Detail usages on the man page
Date: Tue,  6 Feb 2018 04:56:28 +0900
Message-Id: <1517860589-19387-1-git-send-email-qpakzk@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There're no descriptions about how to use perf trace with options and commands on the man page, so detail usages

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
---
 tools/perf/Documentation/perf-trace.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 33a88e9..2608d16 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -8,8 +8,10 @@ perf-trace - strace inspired tool
 SYNOPSIS
 --------
 [verse]
-'perf trace'
-'perf trace record'
+'perf trace' [<options>] [<command>]
+'perf trace' [<options>] -- <command> [<options>]
+'perf trace record' [<options>] [<command>]
+'perf trace record' [<options>] -- <command> [<options>]
 
 DESCRIPTION
 -----------
-- 
2.7.4
