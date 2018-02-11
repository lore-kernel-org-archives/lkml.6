Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeBKUjC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 15:39:02 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45597 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753667AbeBKUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 15:39:00 -0500
X-Google-Smtp-Source: AH8x226A7YvVKJzLiSZ3xQM/sSkujmwhEtQqtpWsL9HiJhQqJvbi9km6BEFvjigyOal8XLDOCKXLZg==
From: Sangwon Hong <qpakzk@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, Sangwon Hong <qpakzk@gmail.com>
Subject: [PATCH 2/2] perf mem: Document a missing option
Date: Mon, 12 Feb 2018 05:38:37 +0900
Message-Id: <1518381517-30766-2-git-send-email-qpakzk@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518381517-30766-1-git-send-email-qpakzk@gmail.com>
References: <1518381517-30766-1-git-send-email-qpakzk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing --force option on the man page.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
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
-- 
2.7.4
