Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637487; cv=none;
        d=google.com; s=arc-20160816;
        b=PITAEQgxE6T1wzYaf/dfcKhfArznAj5AWmUY8sKvyz5FGe45Rg0n/pCxqXlmwCbay6
         Npf+0S0Rrv3mkwGVfPi74VvgzFMPrKJmpHo/BgAdAUE6iiF25m+dUUXsY7a9FOAyUO13
         OYn2pt+jAhCRucY4NEUEJaTnib3KYjNK+ibbcabUKazuU2qxmkInLOkcv92ulVSKrDOM
         KbCpE7QuJQCY6Q41xhcV/2VtQMmzjUZ1jfGy90B0R6gIx5YD7PRkW1NdWMdwpmPgEBIJ
         Swzyf1ofvBvUkLp65O6Il5AtjcsO/SyixiZYKr/oJ2l6g9W56UNqiXQ0CaltWn+W5o8/
         nhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=qHhNWUPX6Z+YUYilCv+rr4TxQ4zBsXxqdG0SAuEEDlc=;
        b=fMG9Yq/DqcMSCOCGbur3rre5PsXgreAcegQ62DbDMwnMBkjuh6KLspcQleJnVPT6Vi
         TV4exklbuqwYKyLyKulCb+inZlRcBKeM5ddnCVCh3d5jWFSkLcrR+NlWCJhmpuZ8c7FM
         kjwivYhJTs/cGMGwyWXjUK3Gn4TTDACv95BtYfdI8uJstek4dd+yHwC/HUbGPAjIREPN
         ZZGrZTwJ7KOupO7jxmwSMebaQzRnjOTUfwAuEA6Co7+fqxek78QR8AiIOB2nMuASCjuB
         y+ZTkwfxy+LVUYhMc90NjYVdLU1hZKr/RMqrB6eq2DwiQIBl+VJSjD52Kywdf4PaLiqx
         dJGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=WlY4VPgg;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=WlY4VPgg;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx4/yqRbQpQIOgnowZLbb3Wf7V73QVrFsKwSTaRwxN44Yz5IHJTB53rHs/2W6vhjYTjotevULLw==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 05/14] staging: iio: ad7746: Reorder includes alphabetically
Date: Fri, 13 Apr 2018 13:36:42 -0300
Message-Id: <1523637411-8531-6-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649702624399109?=
X-GMAIL-MSGID: =?utf-8?q?1597649702624399109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 82fac76..9ef476a 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -6,15 +6,15 @@
  * Licensed under the GPL-2.
  */
 
-#include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/i2c.h>
-#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.7.4
