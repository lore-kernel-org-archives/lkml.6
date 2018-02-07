Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032892; cv=none;
        d=google.com; s=arc-20160816;
        b=KkrXJc5022rJiCQ4And78CL/MWQS8m1U2cb5VXI2Q5q3ky7OfV7Mqm1wamjGmdrkgv
         eoF0xg9M84Qjy17h7KvvoNzxPSS/comMw2Ouwy9q8QwyWtsYhCHFTNQv/YSpdmhHoo++
         0Johk7M2OR1U2AkZpIxkVLKM+D9RNxWQFtWiPKM1k0G1kWRmK2rzYzAkxDnzLLjHzLh4
         xxW46vGOC1hdkzcjjRIUujWqX48X7I5+xXAIBZ2t+yQoxtxVIxyq1liiodapemY6X5ut
         4T08fZl46A1Awbrq2cOy8XINSK88zB4mVNlhrNxEGrjt2qQ/fYz3ro6ABZ4Bjk4qlNEQ
         wuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TJzKoJmFvJVWsJywMmBKh3mQnmyTzxCKZqQ4QQNWAMI=;
        b=zkdm7tH4txO3W6Lc533ioixYWUN3rLLysH529szeEuJVk0nCEUlu1LmU2fOiCBTZNV
         xI3nsQboRn+HrR21qtrpO/6AT96jN0HCt0uFBS1rqrhLElvf24iE8yl86oDWKXg8Mj3Y
         MHc8PkKhD8YAlx07krz3W868gP6Ynf41m5FPzPBEFdDJy071zeZTmv6mguiqsALncaW1
         Crx/c5kSEtt/zcrlZRBF/o2pT91o5OEHVLppHmPUnAmcB96gxX5MGykbPaY6XvQIDG49
         dbDGSVCCyN6W7qSxVtm1pEoWJFCFBPRKuAoZ1ZajP79P8+9Vqpjj1FAABTjS84VIae2u
         ISAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OFNdsF5p;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OFNdsF5p;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224flwgxCEMWxb00yVr4tiARWnoTxSCvItuuMYUShQ+2uOQeU1sL7/kGpOJGOG3gHwWApw3p3A==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 10/12] parport: Sort headers alphabetically
Date: Wed,  7 Feb 2018 19:47:57 +0000
Message-Id: <1518032879-5844-10-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772858026721909?=
X-GMAIL-MSGID: =?utf-8?q?1591772858026721909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

While here, remove init.h inclusion since we are not using it directly and
module.h will do this for us.

No functional changes intended.

Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_serial.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 08e218e..d141e31 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -17,14 +17,14 @@
  *
  */
 
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/parport.h>
 #include <linux/parport_pc.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
 #include <linux/8250_pci.h>
 
 enum parport_pc_pci_cards {
-- 
2.7.4
