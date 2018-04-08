Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeDHUUw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeDHUSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BA621785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201836.218208531@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>
Subject: [for-next][PATCH 17/23] Ktest: add email options to sample.config
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0017-Ktest-add-email-options-to-sample.config.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Tianyang Chen <tianyang.chen@oracle.com>

A block of email options is added under the optional config section.

Link: http://lkml.kernel.org/r/1522094884-22718-5-git-send-email-tianyang.chen@oracle.com

Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/sample.conf | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index f5b58addb1d1..d1a2626aaa0a 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -401,6 +401,28 @@
 
 #### Optional Config Options (all have defaults) ####
 
+# Email options for receiving notifications. Users must setup
+# the specified mailer prior to using this feature.
+#
+# (default undefined)
+#MAILTO =
+#
+# Supported mailers: sendmail, mail, mailx
+# (default sendmail)
+#MAILER = sendmail
+#
+# Errors are defined as those would terminate the script
+# (default 1)
+#EMAIL_ON_ERROR = 1
+# (default 1)
+#EMAIL_WHEN_FINISHED = 1
+# (default 0)
+#EMAIL_WHEN_STARTED = 1
+#
+# Users can cancel the test by Ctrl^C
+# (default 0)
+#EMAIL_WHEN_CANCELED = 1
+
 # Start a test setup. If you leave this off, all options
 # will be default and the test will run once.
 # This is a label and not really an option (it takes no value).
-- 
2.16.3
