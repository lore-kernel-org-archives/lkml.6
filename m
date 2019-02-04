Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D459BC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5632083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549316765;
	bh=EkyHHZ1S8VTPJzcnInoUl/2fIwZOGTZcXHSRkuDRTSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=SK/MuX06N55mgeTHsyYbj4MEkHCKfOsyydJENHQ0jB8bZrP0wVM4iZwKlK9VYqI8r
	 hmszS5wkCrQw9UVoBuKOOHKSuv42rHEJTuB5M6uvPMYJJY/fdlZTtVmESX/578ofmw
	 NyjmrwNJCEggkjtn4MEJF1wXD0k8zL8wHcIODlk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfBDVpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730311AbfBDVpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:45:41 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CEF12184E;
        Mon,  4 Feb 2019 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549316740;
        bh=EkyHHZ1S8VTPJzcnInoUl/2fIwZOGTZcXHSRkuDRTSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=r4XeOGlkbNe1Jhq8DN8ImHzj+LfoOofhxp0R+K6GIVqUMes6b8KlLQVv45kymbT2y
         1sBI/85c5SgQ//Fd2UiQPQk7ggGyX/ucNgGc1FQ2r23dk6QzDvDLrbVrurkUC+zR6h
         za/4t+xJrrS3L1r7PQ/vs4tF3W8VybbUIo2YjfWc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v13 11/15] tracing: Add SPDX license GPL-2.0 license identifier to inter-event testcases
Date:   Mon,  4 Feb 2019 15:45:05 -0600
Message-Id: <2801ba691f74494510a9103c28b51adad88b97b3.1549310519.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1549310519.git.tom.zanussi@linux.intel.com>
References: <cover.1549310519.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549310519.git.tom.zanussi@linux.intel.com>
References: <cover.1549310519.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Apparently this directory was missed in the license cleanup process -
add the missing identifiers to the trigger/inter-event test cases.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc  | 1 +
 .../ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc  | 1 +
 .../test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc      | 1 +
 .../ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc    | 1 +
 .../ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc     | 1 +
 .../test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc      | 1 +
 .../ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc       | 1 +
 .../test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
index 401104344593..9912616a8672 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test extended error support
 
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index f59b2a9a1f22..77be6e1f6e7b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test field variable support
 
 fail() { #msg
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 524d9ce361e2..f3eb8aacec0e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event combined histogram trigger
 
 fail() { #msg
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
index 4ddc546771b5..d281f056f980 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test multiple actions on hist trigger
 
 fail() { #msg
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index 39fb65b0cd9f..a708f0e7858a 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch action
 
 fail() { #msg
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index 81ab3939c96a..dfce6932d8be 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch-onmax action
 
 fail() { #msg
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 1180ab5f0845..0035995c2194 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmax action
 
 fail() { #msg
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
index 41128219231a..df44b14724a4 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test synthetic event create remove
 
 fail() { #msg
-- 
2.14.1

