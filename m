Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521821705; cv=none;
        d=google.com; s=arc-20160816;
        b=aHEbPuiMh7ZRRt9hIp85O/MODgHYmbJmdszHyoa+j1wd+3BSZDEX05efvcoizproYn
         fRCWWVcNQ8PvKI7QO8VRU97XjysquXFN7H4KjDg/PgX3zzHNofPIPAsPF7fZj6k6Mv8Q
         g8mrhbOAurnSSEPfpDX7euaLwzk+rRqcdI/RsHmZ32n7YlMqFfhpWhS8XgiQThmMDD4j
         tUubzgf2gkNbq5dbr1KZ0aSkEcomATd4rvGOKnp5xmewnxVp5isddp65nqyoKD7wUh2L
         LV8N7QPa8thi2bv88mbk/dPH7DFCy7Tv1pSG6Y0/M+CWXZWSymJNPY4qZviL5q2bOdPs
         IL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=22V7Tf79C9gFiHu6wRYdNDdtzOoh5HnySd8HBENDiHI=;
        b=tSkdhgUhwC5LFHhykcwsRFLJxDuZSnHF9cdskL71BnPt5xa69js5FqSeIurJMytLB2
         57AdSrgXazUXyPo2RYsH6nRJs+tQxAgJ/jfpoWZ1v+E59EMqUjt5QBOeVyLXRW7QLzDF
         8eXdqMD0E/tco9D+DWjjgE/uN9xisKZtbNLcS+WT9k6ozta9fs6HAQrplb2H24yTyvDa
         uIxkVBQ1NJAEWmRxT1mjDzeQI3rdp0TIXllGm/FjZV/Bd6dDPsdKuQZ9aUNwxo8Cdlp9
         JSRR+lQAH9OZMJcFvzGacL1bNd8IYuElW00rUC1oMrer2YQn0MA/PqUSM+OdBYfZIhw8
         7wYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=nZRcrq0m;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=nZRcrq0m;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELuqZSCWRZ0AkK6ej3AlpMpE807+uNACxqCJAMdq5BZpAoxIQFy6iY4S7eMqUHHgd1po49Alvw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2] eeprom: at24: use SPDX identifier instead of GPL boiler-plate
Date: Fri, 23 Mar 2018 17:15:02 +0100
Message-Id: <20180323161502.28623-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595745717159531476?=
X-GMAIL-MSGID: =?utf-8?q?1595745717159531476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace the GPL (or later) header with the SPDX identifier
for GPL-2.0+.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 01f9c4921c50..a9a6cde23be9 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -1,14 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * at24.c - handle most I2C EEPROMs
  *
  * Copyright (C) 2005-2007 David Brownell
  * Copyright (C) 2008 Wolfram Sang, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.16.1
