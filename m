Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeDEJ2j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeDEJ2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:28:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB451217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 0/2] selftests: tracing: Update inter-event testcases
Date: Thu,  5 Apr 2018 18:28:11 +0900
Message-Id: <152292049091.15769.13306554953968999494.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've fixed a testcase for inter-event extended error
and added a testcase for multiple actions on trigger,
which is based on what Tom shown in his mail.

This series can be applied on Steven's tracing repo.

git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
ftrace/core

Tom, could you review it?

Thanks,

---

Masami Hiramatsu (2):
      selftests: ftrace: Fix trigger extended error testcase
      selftests: ftrace: Add a testcase for multiple actions on trigger


 .../inter-event/trigger-extended-error-support.tc  |    2 -
 .../inter-event/trigger-multi-actions-accept.tc    |   44 ++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
