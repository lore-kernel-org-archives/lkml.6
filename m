Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeAaIML (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:12:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22368 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753337AbeAaIMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:12:08 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="36418689"
From: Cao jin <caoj.fnst@cn.fujitsu.com>
To: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <arnd@arndb.de>, <trivial@kernel.org>
Subject: [PATCH] trivial: typofix in vmlinux.lds.h
Date: Wed, 31 Jan 2018 16:11:49 +0800
Message-ID: <20180131081149.9183-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: C4AAA49F19B7.AD1B4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aling --> aligned

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 include/asm-generic/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ee8b707d9fa9..470c41d2e272 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -468,7 +468,7 @@
 	MEM_KEEP(exit.text)						\
 
 
-/* sched.text is aling to function alignment to secure we have same
+/* sched.text is aligned to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
 		ALIGN_FUNCTION();					\
@@ -476,7 +476,7 @@
 		*(.sched.text)						\
 		VMLINUX_SYMBOL(__sched_text_end) = .;
 
-/* spinlock.text is aling to function alignment to secure we have same
+/* spinlock.text is aligned to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define LOCK_TEXT							\
 		ALIGN_FUNCTION();					\
-- 
2.14.3
