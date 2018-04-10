Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDJG6h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:58:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59254 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDJG6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:58:36 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
To: akpm@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de,
        keescook@chromium.org, pombredanne@nexb.com, yuval.shaia@oracle.com,
        bp@suse.de, abbotti@mev.co.uk, rdunlap@infradead.org, bhe@redhat.com,
        yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org
Subject: [PATCH] linux/kernel.h: Fix minor type in comment
Date: Tue, 10 Apr 2018 09:57:34 +0300
Message-Id: <20180410065734.4883-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.14.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=820
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100072
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 include/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index ce51455e2adf..a5b4ba3bdb61 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -651,7 +651,7 @@ do {									\
  * your code. (Extra memory is used for special buffers that are
  * allocated when trace_printk() is used.)
  *
- * A little optization trick is done here. If there's only one
+ * A little optimization trick is done here. If there's only one
  * argument, there's no need to scan the string for printf formats.
  * The trace_puts() will suffice. But how can we take advantage of
  * using trace_puts() when trace_printk() has only one argument?
-- 
2.14.3
