Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932895AbeEHV3n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:29:43 -0400
Received: from a8-200.smtp-out.amazonses.com ([54.240.8.200]:40802 "EHLO
        a8-200.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756021AbeEHV1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:27:46 -0400
From: Jeremy Cline <jeremy@jcline.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 3/8] perf scripts python: Add Python 3 support to SchedGui.py
Date: Tue, 8 May 2018 21:27:45 +0000
Message-ID: <0100016341a72d26-75729663-fe55-4309-8c9b-302e065ed2f1-000000@email.amazonses.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
References: <cover.1525811971.git.jeremy@jcline.org>
X-SES-Outgoing: 2018.05.08-54.240.8.200
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a single syntax error in SchedGui.py to support both Python 2 and
Python 3. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 .../scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
index fdd92f699055..cac7b2542ee8 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
@@ -11,7 +11,7 @@
 try:
 	import wx
 except ImportError:
-	raise ImportError, "You need to install the wxpython lib for this script"
+	raise ImportError("You need to install the wxpython lib for this script")
 
 
 class RootFrame(wx.Frame):
-- 
2.17.0
