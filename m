Return-Path: <himanshujha199640@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520236194; cv=none;
        d=google.com; s=arc-20160816;
        b=CqgR+3q1elZeRzH5PZBHLUMyb6TYnwWgP1O584bB38YBjVugu0RFaOcLKLp9MEx2nb
         3HwKN8Fg3th6smzXkhH5Rd8MXgBmF0Thenmluak9pmZguUO501h1QGta7iP3Lct5Ud5E
         Xr9VzfA8WgFltNEXUWihFnCyAilSAnEX1/Io4lEM6VyyU70CgdGGpBOAuPRsPFXoen86
         OJ8YhG2IHMuk9d8CtJ7CJLRfpepw9nGB5/98HrrEt5/Oj0ab4mVIujJQWaGfZPk1nW/c
         PQpzRDVvTkA/UOusXyuertTvwMX0YLkmq2Jtl+xSWeDctmI2hSKXJP9VFPXLtntKs66G
         8MrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=pMKwFXZ1cGq0S9zVmk8HEuQGY1rcGisKP1RD5NTvrY0=;
        b=ERVNhCjMUccM4ky4OePDjv4BtEDAT2s/Br5BQb4tjMsu7250WpcbLOV33FS2teQosp
         IGebzP8LsOQIZ1YN/6sOGkH58jqFCXOvsLGJjJhnP1OGasUSex4TdZQMlwiQah71Z3yP
         OB40sHjLRMZun5iWAQfU3zOyItBdKqgye4lkfAl/oCCG3GLa3pFM3WkvwBZfgPZ0iDLO
         2dgE/JjeHAgjjajnR0oC2qQkZzWq2INfTsm/SHOG51cKoKz0KZgGyRT/YGrjFA8V+RJq
         vKvurHnh/5cR6Uk38yBDPlq9A0E4zrCrCblFWwR2wQ7tF1FjApBloVpflawLsWzGcbPQ
         A2wQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nVG0BWns;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nVG0BWns;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs8oJaO+qWFFKblReQP9oEdy+TNOF/hBDSlK3PCKZFT+0gcZhiJF4wk6F3eANcwpROckuNO+g==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 01/11] Staging: iio: accel: Prefer alphabetical sequence of header files
Date: Mon,  5 Mar 2018 13:19:20 +0530
Message-Id: <1520236170-14668-2-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594083187913405658?=
X-GMAIL-MSGID: =?utf-8?q?1594083187913405658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arrange header files in alphabetical sequence to improve readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 2ebd275..0f6a204 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -7,13 +7,13 @@
  */
 
 #include <linux/delay.h>
-#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.7.4
