Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeCEOai (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752562AbeCEOae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:30:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2C521772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/28] perf tests: Rename trace+probe_libc_inet_pton to record+probe_libc_inet_pton
Date: Mon,  5 Mar 2018 11:29:12 -0300
Message-Id: <20180305142932.16921-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
 rename tools/perf/tests/shell/{trace+probe_libc_inet_pton.sh => record+probe_libc_inet_pton.sh} (100%)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
similarity index 100%
rename from tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
rename to tools/perf/tests/shell/record+probe_libc_inet_pton.sh
-- 
2.14.3
