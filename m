Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3734533-1521628184-2-4215779079648308798
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628183; b=OctlKE+10IJWlMLNSZF1iVlbBWSFTzS3WXdn+/SSIt3PRtH
    u9BEV5KYvxH35Fy+jksp2ysCrL0a/EkQTouJ5N4Ey4qBZudhscpRSldaUATqIwxx
    CRFsmZ/3up3oWDKHWycBHq5QEXYOzi3b3l9a92QEbctcfsTTFRAtK87HyKDxOJUt
    GYh+YpMrerVKvoWaGy12uylp4O7nFVms4iHkzv4Lo4++/2f8gGGzyRb5x3viSci5
    iSYxzSOikOzu3g+WR5C3SYRYbilqo4j57XZbm28XVH78+xDfQT3Dgm9P25VBnLWD
    Mr5DrISxs9a1Hzz00u7c8YqWcz3D4sNp6nb8alw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628183; bh=c
    GRkz36Up80r7dUq1FQmCs2Z+ZPJcX33KvcVbS69gkA=; b=sJIzhovuRk/vw6/pZ
    DXiOx6Ct6GiqP8SD5qJH3ShmUOR10TGcZfkvRZz/WBo4yTlSLuxwh29qIiFkiPwj
    edjLDiiR9TsBaR9FZB9XVJTGpUtv/oaQyAUirpUO5mL4rLvl83dS626EUwasRZjH
    B/8LB2XLt7ZZfaftlm5gMgrYgy5PcJORqzrnIbc2svoPANTaYvGZSG7t9GhL7jV3
    YW20WG/vYLsidmKC8xy67oaTa08UWKZxqS5hCo5CUdUhxPqRkKY7xSzZL4JjlMzi
    5BBCx/OIxPVH5l29HrIr9UawoxZFVgsEOoUeRe1wleMU86+R7SGRc9Vna+cguVXL
    bY1RQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=WlbLElG/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=WlbLElG/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 11/11] staging: iio: tsl2x7x: add copyright
Date: Wed, 21 Mar 2018 06:29:12 -0400
Message-Id: <20180321102912.5130-12-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321102912.5130-1-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Jon.Brenner@ams.com, pmeerw@pmeerw.net,
 knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add Brian Masney's copyright and to the list of module authors for all
of the staging cleanups. This patch also update's Jon Brenner's current
work email address since AMS now owns TAOS.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 5f78664d2b0e..77a81d75af4f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -3,6 +3,7 @@
  * and proximity detection (prox) within the TAOS TSL2X7X family of devices.
  *
  * Copyright (c) 2012, TAOS Corporation.
+ * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1744,6 +1745,7 @@ static struct i2c_driver tsl2x7x_driver = {
 
 module_i2c_driver(tsl2x7x_driver);
 
-MODULE_AUTHOR("J. August Brenner<jbrenner@taosinc.com>");
+MODULE_AUTHOR("J. August Brenner <Jon.Brenner@ams.com>");
+MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
 MODULE_DESCRIPTION("TAOS tsl2x7x ambient and proximity light sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
