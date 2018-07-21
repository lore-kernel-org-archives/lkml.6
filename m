Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010BAECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BAE2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="kkMkLJyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BAE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeGUUbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:31:53 -0400
Received: from vern.gendns.com ([206.190.152.46]:52764 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbeGUUbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hSTPTz7ewFuBvcyG5evPdDmfGO6DhzLzZkuGIj/eogo=; b=kkMkLJyix1GIB8mCY9xsBO4IA
        q6eahwk9aAEJUDHPvttLuN7+JDQ4gVXHqSR/1WGmw2Kgb8NThI2eMvf1BWeWQaheq1WCCqvVvwquR
        kabxvXsoMTUWM7+zZkEGYYlL7YTZratABWqv6Z24T9VLYaaxLsHe6IeuY4lCxlII9AVr4HbC5e/GQ
        qfklusTR+Ay5bJeLL7D1aoBdxqoXmVUXVjR92BzpfgmEkihRZekzImKO2Z5DTjq8Oy8AFYEmvK0rK
        vMhaidBiydR4SMHkDlxaX343Tj5lvJ74jcXmYzsR8ngbV9aKQiwqd3oLRSjKNcdtiE5dsJiJEMVuj
        11EcfGHEw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:35490 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fgxhX-009bOk-MY; Sat, 21 Jul 2018 15:37:59 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: adc: ti-ads7950: use SPDX-License-Identifier
Date:   Sat, 21 Jul 2018 14:37:33 -0500
Message-Id: <20180721193734.6427-2-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721193734.6427-1-david@lechnology.com>
References: <20180721193734.6427-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the ti-ads7950.c file to use SPDX-License-Identifier
instead of more verbose license text.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/iio/adc/ti-ads7950.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0225c1b333ab..f08c4de2bd10 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Texas Instruments ADS7950 SPI ADC driver
  *
@@ -10,15 +11,6 @@
  * And also on hwmon/ads79xx.c
  * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
  *	Nishanth Menon
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/acpi.h>
-- 
2.17.1

