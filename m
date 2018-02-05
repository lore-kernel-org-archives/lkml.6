Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeBELyf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:54:35 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35101 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBELy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:54:27 -0500
X-Google-Smtp-Source: AH8x227QVBvIJNmvY27sCSI2flaXVs9gq7MIAWqPJfdWTOFpG19/RaYnwBkk/3z1NuaWbWN+A9xhiA==
From: Sangwon Hong <qpakzk@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, Sangwon Hong <qpakzk@gmail.com>
Subject: [PATCH] perf data: Document missing --force option
Date: Mon,  5 Feb 2018 20:54:13 +0900
Message-Id: <1517831653-32187-1-git-send-email-qpakzk@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add --force option on the man page

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
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
-- 
2.7.4
