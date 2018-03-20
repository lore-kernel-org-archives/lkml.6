Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeCTGgA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:36:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54543 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeCTGf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:35:56 -0400
Date: Mon, 19 Mar 2018 23:35:21 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0jwfueooddwfsw9r603belxi@git.kernel.org>
Cc: acme@redhat.com, yao.jin@linux.intel.com, dsahern@gmail.com,
        mingo@kernel.org, w@1wt.eu, tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com, wangnan0@huawei.com, hpa@zytor.com,
        jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        hpa@zytor.com, wangnan0@huawei.com, tglx@linutronix.de, w@1wt.eu,
        mingo@kernel.org, dsahern@gmail.com, yao.jin@linux.intel.com,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Document --ignore-vmlinux
Git-Commit-ID: a8403912d04e2c8271653bb5b7f6294dc6d322ac
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

Commit-ID:  a8403912d04e2c8271653bb5b7f6294dc6d322ac
Gitweb:     https://git.kernel.org/tip/a8403912d04e2c8271653bb5b7f6294dc6d322ac
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 16 Mar 2018 16:24:34 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Mar 2018 13:51:52 -0300

perf top: Document --ignore-vmlinux

We've had this since 2013, document it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Willy Tarreau <w@1wt.eu>
Fixes: fc2be6968e99 ("perf symbols: Add new option --ignore-vmlinux for perf top")
Link: https://lkml.kernel.org/n/tip-0jwfueooddwfsw9r603belxi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index a039407d63b8..114fda12aa49 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -67,6 +67,9 @@ Default is to monitor all CPUS.
 --vmlinux=<path>::
 	Path to vmlinux.  Required for annotation functionality.
 
+--ignore-vmlinux::
+	Ignore vmlinux files.
+
 -m <pages>::
 --mmap-pages=<pages>::
 	Number of mmap data pages (must be a power of two) or size
