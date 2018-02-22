Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932396AbeBVMQl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:16:41 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:61683 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932344AbeBVMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:16:34 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w1MCFdUH020774
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] linux/const.h: refactor _BITUL and _BITULL a bit
Date: Thu, 22 Feb 2018 21:15:14 +0900
Message-Id: <1519301715-31798-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanups available by _UL and _ULL.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
V2: https://patchwork.kernel.org/patch/9498269/


Changes in v3: None
Changes in v2: None

 include/uapi/linux/const.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index 09bc0e0..5ed721a 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -25,7 +25,7 @@
 #define _UL(x)		(_AC(x, UL))
 #define _ULL(x)		(_AC(x, ULL))
 
-#define _BITUL(x)	(_AC(1,UL) << (x))
-#define _BITULL(x)	(_AC(1,ULL) << (x))
+#define _BITUL(x)	(_UL(1) << (x))
+#define _BITULL(x)	(_ULL(1) << (x))
 
 #endif /* _UAPI_LINUX_CONST_H */
-- 
2.7.4
