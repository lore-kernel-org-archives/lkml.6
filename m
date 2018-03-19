Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451050; cv=none;
        d=google.com; s=arc-20160816;
        b=bdJ4eOqQ5Kr1nAZGONosEFKrIbRaSw04Ro5l5Hp2Pfh/wT1nRQCfX2mBZLKMTskpjr
         472W1kDFx+jgHz2IPWxL98XNjHOFU78xubuaB2QuDYSDX8TnKOxe/4J5RAmJ86IQ9Orx
         /wxX/OKNwSdjY5pfkfm9+mKkC5VskHEQgL9/CMsVRNMBEMOw+7xZUp3WaSOGuf8nDSMU
         rBF6OVgpiVpI3AcYKOR+GUH+balyPlNnQrhcwEYMvBSHhOm0Cxxw76SonDwVymlwHuCf
         BHIEtOJtWZJ+sEBet5b6gAhvV8/0Eug/vgMTPEeEZIiwyS5uLXhtQ+2ZITLTBr55oTSX
         iLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=3vIZOhZ+dVkbCDwVE3m42vtwlyJU+tqySamR2bKnfrA=;
        b=xNp0JDnj7uouXYRsbWRZWyxSc3ngNsMkFLdyKLvQI3zfmtrUCLCkJeJmMnWfv3cVPe
         8qGiSceDs/EbMCimT68jzAbUy2UBRMsQTBlFynltzBur6vcJ6XzJsYKYY0mAgixf4uPB
         y65AHxW651H/sYtQ7tPddQxJ07vIH972lwATwaFMwwOJS19Pr2y+lAVJ5U9qgAd9srSV
         692uP9lmIksO+7MsvW2QI/w+NEbPxZuTbQg2hFwljXE9VADhbfvSsc20wXt11/wL6dPm
         I6AZ7uN9/Ed6w5UqTseDCQ3BnLqLV8YxBengLASyS575hyCcvD/7FjysVeOTG28Z4kLm
         N6Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=LkAEmpJz;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=LkAEmpJz;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELtyYbhODKHg3ZC1mBogeuRM+0Udqr6rn7cL+tAHJRXohjQLMUYqMg7342FVUf2B2kGZuCaAag==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL boiler-plate
Date: Mon, 19 Mar 2018 10:17:04 +0100
Message-Id: <20180319091721.18193-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357056282465424?=
X-GMAIL-MSGID: =?utf-8?q?1595357056282465424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace the GPL header with an SPDX identifier for GPL-2.0.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2a4154eeb1bd..0e06201d33c9 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -1,14 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
