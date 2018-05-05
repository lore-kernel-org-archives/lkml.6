Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeEEBRF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:17:05 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50557 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeEEBRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:17:03 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/24] selftests: locking: add Makefile for locking test
Date: Fri,  4 May 2018 19:13:21 -0600
Message-Id: <20180505011328.32078-17-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Makefile for locking test.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/locking/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 tools/testing/selftests/locking/Makefile

diff --git a/tools/testing/selftests/locking/Makefile b/tools/testing/selftests/locking/Makefile
new file mode 100644
index 000000000000..e168a2e34bc2
--- /dev/null
+++ b/tools/testing/selftests/locking/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for locking/ww_mutx selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := ww_mutex.sh
+
+include ../lib.mk
-- 
2.14.1
