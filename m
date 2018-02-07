Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeBGJwc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:52:32 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39409 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbeBGJwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:52:30 -0500
X-Google-Smtp-Source: AH8x227r4elNWYcleZ153N8iyikZ6VNpixez5jV/uFEzCVNAaAuw04ezZ3rKKyw8bwNYWmmpU3fhvA==
From: Jaecheol Shin <jcgod413@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, jcgod413 <jcgod413@gmail.com>
Subject: [PATCH] perf annotate: Add missing arguments in Man page
Date: Wed,  7 Feb 2018 18:52:05 +0900
Message-Id: <20180207095205.62715-1-jcgod413@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jcgod413 <jcgod413@gmail.com>

Some options must require an argument. But input, stdio-color, cpu have no them.
So I added it.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Signed-off-by: Jaecheol Shin <jcgod413@gmail.com>
---
 tools/perf/Documentation/perf-annotate.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index c635eab6af54..292809c3c0ca 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -21,7 +21,7 @@ If there is no debug info in the object, then annotated assembly is displayed.
 OPTIONS
 -------
 -i::
---input=::
+--input=<file>::
         Input file name. (default: perf.data unless stdin is a fifo)
 
 -d::
@@ -69,7 +69,7 @@ OPTIONS
 
 --stdio:: Use the stdio interface.
 
---stdio-color::
+--stdio-color=<mode>::
 	'always', 'never' or 'auto', allowing configuring color output
 	via the command line, in addition to via "color.ui" .perfconfig.
 	Use '--stdio-color always' to generate color even when redirecting
@@ -84,7 +84,7 @@ OPTIONS
 --gtk:: Use the GTK interface.
 
 -C::
---cpu:: Only report samples for the list of CPUs provided. Multiple CPUs can
+--cpu=<cpu>:: Only report samples for the list of CPUs provided. Multiple CPUs can
 	be provided as a comma-separated list with no space: 0,1. Ranges of
 	CPUs are specified with -: 0-2. Default is to report samples on all
 	CPUs.
-- 
2.14.3 (Apple Git-98)
