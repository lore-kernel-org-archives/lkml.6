Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932230AbeBPJnN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:43:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57503 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeBPJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:43:11 -0500
Date: Fri, 16 Feb 2018 01:43:02 -0800
From: tip-bot for Sangwon Hong <tipbot@zytor.com>
Message-ID: <tip-ba7e851642f48002def3450b279598c187721fd0@git.kernel.org>
Cc: acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        treeze.taeung@gmail.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        qpakzk@gmail.com
Reply-To: hpa@zytor.com, treeze.taeung@gmail.com, mingo@kernel.org,
        acme@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, qpakzk@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <1517831315-31490-1-git-send-email-qpakzk@gmail.com>
References: <1517831315-31490-1-git-send-email-qpakzk@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf data: Document missing --force option
Git-Commit-ID: ba7e851642f48002def3450b279598c187721fd0
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

Commit-ID:  ba7e851642f48002def3450b279598c187721fd0
Gitweb:     https://git.kernel.org/tip/ba7e851642f48002def3450b279598c187721fd0
Author:     Sangwon Hong <qpakzk@gmail.com>
AuthorDate: Mon, 5 Feb 2018 20:48:35 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:57:33 -0300

perf data: Document missing --force option

Add the --force option to the man page.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1517831315-31490-1-git-send-email-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-data.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index f0796a4..90bb4aa 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -30,6 +30,10 @@ OPTIONS for 'convert'
 -i::
 	Specify input perf data file path.
 
+-f::
+--force::
+	Don't complain, do it.
+
 -v::
 --verbose::
         Be more verbose (show counter open errors, etc).
