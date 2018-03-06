Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeCFGoV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:44:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCFGoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:44:18 -0500
Date: Mon, 5 Mar 2018 22:43:55 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4f67336870f641daa485ea504777486e24a9aece@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, hpa@zytor.com, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: mingo@kernel.org, peterz@infradead.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com
In-Reply-To: <20180301165215.6780-2-jolsa@kernel.org>
References: <20180301165215.6780-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Rename trace+probe_libc_inet_pton to
 record+probe_libc_inet_pton
Git-Commit-ID: 4f67336870f641daa485ea504777486e24a9aece
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

Commit-ID:  4f67336870f641daa485ea504777486e24a9aece
Gitweb:     https://git.kernel.org/tip/4f67336870f641daa485ea504777486e24a9aece
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 1 Mar 2018 17:52:15 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 09:58:42 -0300

perf tests: Rename trace+probe_libc_inet_pton to record+probe_libc_inet_pton

Because the test is no longer using perf trace but perf record instead.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180301165215.6780-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../{trace+probe_libc_inet_pton.sh => record+probe_libc_inet_pton.sh}     | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
similarity index 100%
rename from tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
rename to tools/perf/tests/shell/record+probe_libc_inet_pton.sh
