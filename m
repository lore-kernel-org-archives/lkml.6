Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeBQLcD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:32:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34215 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeBQLcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:32:01 -0500
Date: Sat, 17 Feb 2018 03:31:53 -0800
From: tip-bot for Sangwon Hong <tipbot@zytor.com>
Message-ID: <tip-7e99b1972263c2f611d7f2fb67d09f3384006593@git.kernel.org>
Cc: hpa@zytor.com, treeze.taeung@gmail.com, acme@redhat.com,
        mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, qpakzk@gmail.com, tglx@linutronix.de
Reply-To: treeze.taeung@gmail.com, acme@redhat.com, hpa@zytor.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, qpakzk@gmail.com
In-Reply-To: <1518381517-30766-2-git-send-email-qpakzk@gmail.com>
References: <1518381517-30766-2-git-send-email-qpakzk@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mem: Document a missing option
Git-Commit-ID: 7e99b1972263c2f611d7f2fb67d09f3384006593
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

Commit-ID:  7e99b1972263c2f611d7f2fb67d09f3384006593
Gitweb:     https://git.kernel.org/tip/7e99b1972263c2f611d7f2fb67d09f3384006593
Author:     Sangwon Hong <qpakzk@gmail.com>
AuthorDate: Mon, 12 Feb 2018 05:38:37 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:42 -0300

perf mem: Document a missing option

Add the missing --force option on the man page.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1518381517-30766-2-git-send-email-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 4be08a1..b021141 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -28,6 +28,10 @@ OPTIONS
 <command>...::
 	Any command you can specify in a shell.
 
+-f::
+--force::
+	Don't do ownership validation
+
 -t::
 --type=::
 	Select the memory operation type: load or store (default: load,store)
