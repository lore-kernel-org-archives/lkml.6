Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeDFWRi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:17:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47186 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbeDFWRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:17:35 -0400
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com,
        tim.tianyang.chen@alumni.upenn.edu,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [PATCH v3 4/4] ktest: add email options to sample.config
Date: Fri,  6 Apr 2018 15:17:05 -0700
Message-Id: <1523053025-12424-5-git-send-email-tianyang.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523053025-12424-1-git-send-email-tianyang.chen@oracle.com>
References: <1523053025-12424-1-git-send-email-tianyang.chen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804060222
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A block of email options is added under the optional config section.

Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
---
 tools/testing/ktest/sample.conf | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 6c58cd8bbbae..ba3dd4a9c7fb 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -396,6 +396,28 @@
 
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
1.8.3.1
