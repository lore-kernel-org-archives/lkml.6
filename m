Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACAAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3247F2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3247F2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeKMFGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:06:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52971 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeKMFGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:06:02 -0500
Received: from node-1w7jr9qsvbxfi9ota9omrl6fe.ipv6.telus.net ([2001:569:7bc5:1000:8103:8419:bf24:e6ca])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gMHcM-00057u-G7; Mon, 12 Nov 2018 20:11:27 +0100
Date:   Mon, 12 Nov 2018 11:11:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] selftests/ftrace: Fix invalid SPDX identifiers
Message-ID: <alpine.DEB.2.21.1811121108000.14703@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While GPL2.0 looks about right, the correct and valid identifiers for GPL v2
only code are 'GPL-2.0' or 'GPL-2.0-only'.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Shuah Khan (Samsung OSG) <shuah@kernel.org>

---

P.S.: checkpatch.pl emits a warning when crappy license ids are used

 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 +-
 tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc           |    2 +-
 tools/testing/selftests/ftrace/test.d/template                         |    2 +-
 tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc                 |    2 +-
 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc              |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL2.0
+# SPDX-License-Identifier: GPL-2.0
 # description: ftrace - stacktrace filter command
 # flags: instance
 
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL2.0
+# SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function trace with cpumask
 
 if ! which nproc ; then
--- a/tools/testing/selftests/ftrace/test.d/template
+++ b/tools/testing/selftests/ftrace/test.d/template
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL2.0
+# SPDX-License-Identifier: GPL-2.0
 # description: %HERE DESCRIBE WHAT THIS DOES%
 # you have to add ".tc" extention for your testcase file
 # Note that all tests are run with "errexit" option.
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL2.0
+# SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup tracer
 
 if ! which chrt ; then
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL2.0
+# SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup RT tracer
 
 if ! which chrt ; then
