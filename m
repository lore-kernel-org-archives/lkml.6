Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757128AbeD0BE7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:04:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:20910 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeD0BE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:04:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="36775232"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 0/3] A few hist trigger fixes
Date: Thu, 26 Apr 2018 20:04:46 -0500
Message-Id: <cover.1524790601.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Here are a few patches that fix some problems found when testing the
hist trigger inter-event (e.g. latency) support patches.

The first fixes a problem I noticed when printing flags.

The remaining two add some hist_err() calls for fields, the first
reported by Masami, the second something I noticed when fixing the
first.

Thanks,

Tom

The following changes since commit 0566e40ce7c493d39006cdd7edf17bfdc52eb2ac:

  tracing: initcall: Ordered comparison of function pointers (2018-04-26 15:02:46 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-fixes-1

Tom Zanussi (3):
  tracing: Restore proper field flag printing when displaying triggers
  tracing: Add field parsing hist error for hist triggers
  tracing: Add field modifier parsing hist error for hist triggers

 kernel/trace/trace_events_hist.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
1.9.3
