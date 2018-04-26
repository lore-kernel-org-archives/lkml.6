Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeDZGIo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:08:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11414 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751372AbeDZGIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:08:43 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39330747"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/vector: Remove the unused macro FPU_IRQ
Date: Thu, 26 Apr 2018 14:08:32 +0800
Message-ID: <20180426060832.27312-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 0BA0848AE92A.AF5EC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro FPU_IRQ has never been used since v3.10, So remove it.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/irq_vectors.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 57003074bd7a..548d90bbf919 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -114,8 +114,6 @@
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
 
-#define FPU_IRQ				  13
-
 /*
  * Size the maximum number of interrupts.
  *
-- 
2.14.3
