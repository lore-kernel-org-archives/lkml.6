Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52236C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0518024FAF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yetXcNtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0518024FAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeGBSMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:12:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45872 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeGBSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:12:24 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w62ICIf8008096;
        Mon, 2 Jul 2018 13:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530555138;
        bh=pNWj8EQXtENnvhhkHiZmBa9A5nW8s78VCFaancNPPCU=;
        h=From:To:CC:Subject:Date;
        b=yetXcNtqsxi58bMLhXgSuY3igToHzFLAV85PIhzSp+QD6xVy6RNC4FUugB3oj+mHs
         5JcuwT5ugmA+kgJe9k2PGUmvPTFJTAJmHCjBe7Tm+h7lAb9lbp1hfPK2hjxOKlnXAo
         Wi1V7cR8HlWoDClTrC2ZW/d2OFBGOI6GFPJLXRm4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62ICI8A002967;
        Mon, 2 Jul 2018 13:12:18 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 2 Jul
 2018 13:12:18 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 2 Jul 2018 13:12:18 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62ICIDV016772;
        Mon, 2 Jul 2018 13:12:18 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.180.30])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w62ICHx02905;
        Mon, 2 Jul 2018 13:12:17 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jacek.anaszewski@gmail.com>, <andy.shevchenko@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/4] leds: lm3692x: Update license header to SPDX
Date:   Mon, 2 Jul 2018 13:12:13 -0500
Message-ID: <20180702181216.19660-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the license header to the current
SPDX licensing format.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3692x.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 437173d1712c..1a06d8c97789 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -1,17 +1,6 @@
-/*
- * TI lm3692x LED Driver
- *
- * Copyright (C) 2017 Texas Instruments
- *
- * Author: Dan Murphy <dmurphy@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * Data sheet is located
- * http://www.ti.com/lit/ds/snvsa29/snvsa29.pdf
- */
+// SPDX-License-Identifier: GPL-2.0
+// TI LM3692x LED chip family driver 
+// Copyright (C) 2017-18 Texas Instruments Incorporated - http://www.ti.com/
 
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
-- 
2.17.0.582.gccdcbd54c

