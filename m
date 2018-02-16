Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeBPTTg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753677AbeBPTTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961A8217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sangwon Hong <qpakzk@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/41] perf mem: Document a missing option
Date: Fri, 16 Feb 2018 16:17:31 -0300
Message-Id: <20180216191746.11095-27-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

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
index 4be08a1e3f8d..b0211410969b 100644
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
2.14.3
