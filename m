Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935046AbeBMMMZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:12:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43393 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934806AbeBMMMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:12:23 -0500
Date: Tue, 13 Feb 2018 04:12:15 -0800
From: tip-bot for Sangwon Hong <tipbot@zytor.com>
Message-ID: <tip-a3a4bcaeba5cc981783529db0b8609c03c2db38f@git.kernel.org>
Cc: qpakzk@gmail.com, tglx@linutronix.de, namhyung@kernel.org,
        treeze.taeung@gmail.com, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org
Reply-To: treeze.taeung@gmail.com, namhyung@kernel.org, acme@redhat.com,
        hpa@zytor.com, qpakzk@gmail.com, tglx@linutronix.de, jolsa@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1517831315-31490-1-git-send-email-qpakzk@gmail.com>
References: <1517831315-31490-1-git-send-email-qpakzk@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf data: Document missing --force option
Git-Commit-ID: a3a4bcaeba5cc981783529db0b8609c03c2db38f
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

Commit-ID:  a3a4bcaeba5cc981783529db0b8609c03c2db38f
Gitweb:     https://git.kernel.org/tip/a3a4bcaeba5cc981783529db0b8609c03c2db38f
Author:     Sangwon Hong <qpakzk@gmail.com>
AuthorDate: Mon, 5 Feb 2018 20:48:35 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:52 -0300

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
