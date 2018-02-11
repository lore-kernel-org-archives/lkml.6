Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbeBKTiX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 14:38:23 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41521 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753459AbeBKTiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 14:38:22 -0500
X-Google-Smtp-Source: AH8x226yAufKxeJ9fyOk6MCQ0v0qMm4UVlS1JuITP/XCBohbA2n0AK5Lp4yFD0lfr7B/Pr/GUGSVjQ==
From: Sangwon Hong <qpakzk@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, Sangwon Hong <qpakzk@gmail.com>
Subject: [PATCH] perf kallsyms: Fix the usage on the man page
Date: Mon, 12 Feb 2018 04:37:44 +0900
Message-Id: <1518377864-20353-1-git-send-email-qpakzk@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, all man pages highlight only perf and subcommands except perf
kallsyms, which includes the full usage. Fix it for commands to monopolize
underlines.

Second, options can skip when executing perf kallsyms, so add square
brackets between <option>.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
---
 tools/perf/Documentation/perf-kallsyms.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-kallsyms.txt b/tools/perf/Documentation/perf-kallsyms.txt
index 954ea9e..cf9f404 100644
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
-- 
2.7.4
