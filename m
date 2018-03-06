Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeCFGk7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:40:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeCFGk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:40:57 -0500
Date: Mon, 5 Mar 2018 22:40:47 -0800
From: tip-bot for Sangwon Hong <tipbot@zytor.com>
Message-ID: <tip-de7112868829b3286def38297848d5d2592b4a70@git.kernel.org>
Cc: namhyung@kernel.org, qpakzk@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
        treeze.taeung@gmail.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, qpakzk@gmail.com, namhyung@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
        treeze.taeung@gmail.com, acme@redhat.com
In-Reply-To: <1518377864-20353-1-git-send-email-qpakzk@gmail.com>
References: <1518377864-20353-1-git-send-email-qpakzk@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kallsyms: Fix the usage on the man page
Git-Commit-ID: de7112868829b3286def38297848d5d2592b4a70
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

Commit-ID:  de7112868829b3286def38297848d5d2592b4a70
Gitweb:     https://git.kernel.org/tip/de7112868829b3286def38297848d5d2592b4a70
Author:     Sangwon Hong <qpakzk@gmail.com>
AuthorDate: Mon, 12 Feb 2018 04:37:44 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Feb 2018 09:23:36 -0300

perf kallsyms: Fix the usage on the man page

First, all man pages highlight only perf and subcommands except 'perf
kallsyms', which includes the full usage. Fix it for commands to
monopolize underlines.

Second, options can be ommited when executing 'perf kallsyms', so add
square brackets between <option>.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1518377864-20353-1-git-send-email-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-kallsyms.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-kallsyms.txt b/tools/perf/Documentation/perf-kallsyms.txt
index 954ea9e21236..cf9f4040ea5c 100644
--- a/tools/perf/Documentation/perf-kallsyms.txt
+++ b/tools/perf/Documentation/perf-kallsyms.txt
@@ -8,7 +8,7 @@ perf-kallsyms - Searches running kernel for symbols
 SYNOPSIS
 --------
 [verse]
-'perf kallsyms <options> symbol_name[,symbol_name...]'
+'perf kallsyms' [<options>] symbol_name[,symbol_name...]
 
 DESCRIPTION
 -----------
