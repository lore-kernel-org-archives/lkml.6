Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754911AbeEaMRL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:17:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56146 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754197AbeEaMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:17:09 -0400
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, mingo@redhat.com
Subject: [PATCH] ftrace: use non-archaic spelling of failes
Date: Thu, 31 May 2018 09:17:01 -0300
Message-Id: <20180531121701.8972-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8d83bcf9ef69..b218cee1f18c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4788,7 +4788,7 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long ip, int remove,
  * @reset - non zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled
- * If @ip is NULL, it failes to update filter.
+ * If @ip is NULL, it fails to update filter.
  */
 int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
 			 int remove, int reset)
-- 
2.17.0
