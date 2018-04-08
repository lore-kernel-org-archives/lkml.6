Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDHSxZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 14:53:25 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:54887 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeDHSxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 14:53:23 -0400
X-Google-Smtp-Source: AIpwx4+MSN7o7EJWLzzcEGjQmMbSiMWbCSGFKlQmL/2CWDn1BlAz6MePlfF1Ec7o8el06f/lrUmEJA==
Date: Sun, 8 Apr 2018 20:53:20 +0200
From: Laszlo Toth <laszlth@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: remove surplus executable marks
Message-ID: <20180408185320.GA4821@laszlth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszlo Toth <laszlth@gmail.com>
---
 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py | 0
 tools/perf/scripts/python/bin/net_dropmonitor-record                   | 0
 tools/perf/scripts/python/bin/net_dropmonitor-report                   | 0
 tools/perf/scripts/python/bin/stackcollapse-record                     | 0
 tools/perf/scripts/python/bin/stackcollapse-report                     | 0
 tools/perf/scripts/python/net_dropmonitor.py                           | 0
 tools/perf/scripts/python/stackcollapse.py                             | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
 mode change 100755 => 100644 tools/perf/scripts/python/bin/net_dropmonitor-record
 mode change 100755 => 100644 tools/perf/scripts/python/bin/net_dropmonitor-report
 mode change 100755 => 100644 tools/perf/scripts/python/bin/stackcollapse-record
 mode change 100755 => 100644 tools/perf/scripts/python/bin/stackcollapse-report
 mode change 100755 => 100644 tools/perf/scripts/python/net_dropmonitor.py
 mode change 100755 => 100644 tools/perf/scripts/python/stackcollapse.py

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
old mode 100755
new mode 100644
diff --git a/tools/perf/scripts/python/bin/net_dropmonitor-record b/tools/perf/scripts/python/bin/net_dropmonitor-record
old mode 100755
new mode 100644
diff --git a/tools/perf/scripts/python/bin/net_dropmonitor-report b/tools/perf/scripts/python/bin/net_dropmonitor-report
old mode 100755
new mode 100644
diff --git a/tools/perf/scripts/python/bin/stackcollapse-record b/tools/perf/scripts/python/bin/stackcollapse-record
old mode 100755
new mode 100644
diff --git a/tools/perf/scripts/python/bin/stackcollapse-report b/tools/perf/scripts/python/bin/stackcollapse-report
old mode 100755
new mode 100644
diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
old mode 100755
new mode 100644
diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
old mode 100755
new mode 100644
-- 
2.7.4
