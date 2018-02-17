Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeBQLbB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:31:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51133 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeBQLbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:31:00 -0500
Date: Sat, 17 Feb 2018 03:30:51 -0800
From: tip-bot for Jaecheol Shin <tipbot@zytor.com>
Message-ID: <tip-ac2c30683803b08bdf35c08d712eafa1ca496164@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com, jolsa@kernel.org, jcgod413@gmail.com,
        treeze.taeung@gmail.com, namhyung@kernel.org, acme@redhat.com
Reply-To: namhyung@kernel.org, treeze.taeung@gmail.com, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, hpa@zytor.com, jcgod413@gmail.com
In-Reply-To: <20180207095205.62715-1-jcgod413@gmail.com>
References: <20180207095205.62715-1-jcgod413@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Add missing arguments in Man page
Git-Commit-ID: ac2c30683803b08bdf35c08d712eafa1ca496164
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ac2c30683803b08bdf35c08d712eafa1ca496164
Gitweb:     https://git.kernel.org/tip/ac2c30683803b08bdf35c08d712eafa1ca496164
Author:     Jaecheol Shin <jcgod413@gmail.com>
AuthorDate: Wed, 7 Feb 2018 18:52:05 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:41 -0300

perf annotate: Add missing arguments in Man page

Some options must require an argument. But input, stdio-color, cpu have
no them.  So I added it.

Signed-off-by: Jaecheol Shin <jcgod413@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/20180207095205.62715-1-jcgod413@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index c635eab..292809c3 100644
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
